import 'package:flutter/material.dart';
import 'package:vision_erp_app/core/models/employee_model.dart';
import 'package:vision_erp_app/core/models/theme_model.dart';
import 'package:vision_erp_app/core/models/user_model.dart';
import 'package:vision_erp_app/services/attendance_service.dart';
import 'package:vision_erp_app/services/hr_service.dart';


// Utility function for date formatting
String formatDate(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

class HumanResourcesPage extends StatefulWidget {
  final UserModel? user;
  
  const HumanResourcesPage({super.key, this.user});

  @override
  State<HumanResourcesPage> createState() => _HumanResourcesPageState();
}

class _HumanResourcesPageState extends State<HumanResourcesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _lastCheckIn = DateTime.now();
  bool _isCheckedIn = false;
  String _breakStatus = 'No Break';
  final bool _showAddEmployeeQuickAction = false;
  final bool _showManageShiftAction = false;
  final bool _showProcessPayrollAction = false;
  EmployeeStats _employeeStats = EmployeeStats.empty(); // تهيئة بقيم افتراضية
  bool _isLoading = true;
  bool _isEmployeesLoading = true;
  int? _organizationId;
  
  // قائمة الموظفين الحقيقية من API
  List<EmployeeModel> _employees = [];

  // بيانات أخرى
  List<Map<String, dynamic>> _attendance = [];

  final List<Map<String, dynamic>> _leaveRequests = [
    {'id': 'L001', 'employee': 'Ahmed Mohamed', 'type': 'Annual Leave', 'from': '2024-01-20', 'to': '2024-01-25', 'status': 'Pending', 'reason': 'Family vacation'},
    {'id': 'L002', 'employee': 'Sarah Ahmed', 'type': 'Sick Leave', 'from': '2024-01-16', 'to': '2024-01-17', 'status': 'Approved', 'reason': 'Medical appointment'},
    {'id': 'L003', 'employee': 'Yasser Ali', 'type': 'Emergency Leave', 'from': '2024-01-18', 'to': '2024-01-18', 'status': 'Pending', 'reason': 'Family emergency'},
  ];

  final List<Map<String, dynamic>> _payrollRecords = [
    {'period': 'January 2024', 'basicSalary': 5000, 'allowances': 500, 'deductions': 200, 'netSalary': 5300, 'status': 'Processed'},
    {'period': 'December 2023', 'basicSalary': 5000, 'allowances': 450, 'deductions': 180, 'netSalary': 5270, 'status': 'Processed'},
    {'period': 'November 2023', 'basicSalary': 5000, 'allowances': 480, 'deductions': 220, 'netSalary': 5260, 'status': 'Processed'},
  ];
  
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final bool _showEmployeeEditOptions = false;

  @override
  void initState() {
    super.initState();
    
   // الحصول على organizationId
  _organizationId = int.tryParse(
    widget.user?.organizationId.toString() ?? '0'
  );
    
    _tabController = TabController(length: 4, vsync: this);
    
    // تحميل البيانات عند بدء التطبيق
    _initializeData();
  }

  Future<void> _initializeData() async {
  try {
    // تحميل الإحصائيات أولاً (داشبورد)
    await _fetchEmployeeStats();
    
    // تحميل الموظفين (خلفية)
    await _fetchAllEmployeeData();
    
    // تحميل بيانات الحضور
    await _fetchAttendanceData();
    
    // التحقق من حالة الحضور الحالية
    await _checkCurrentAttendanceStatus();
  } catch (e) {
    print('Error initializing data: $e');
    setState(() {
      _isLoading = false;
      _isEmployeesLoading = false;
    });
  }
}
  Future<void> _fetchEmployeeStats() async {
      if (_organizationId == null || _organizationId == 0) {
        print('Invalid organizationId: $_organizationId');
        setState(() {
          _employeeStats = EmployeeStats.empty();
          _isLoading = false;
        });
        return;
      }
      
      setState(() {
        _isLoading = true;
      });
      
      try {
        print('Fetching stats for organization: $_organizationId');
        final stats = await HRService.getEmployeeCounts(_organizationId!);
        
        // التحقق من أن البيانات تم تحميلها بشكل صحيح
        print('📊 Received stats: Total=${stats.allEmployees}, Present=${stats.attendanceToday}, '
              'Leave=${stats.onLeave}, Absent=${stats.absentToday}');
        
        setState(() {
          _employeeStats = stats;
        });
        
        // إذا كانت هناك أعداد موظفين ولكن قائمة الموظفين فارغة، قم بتحميلها
        if (stats.allEmployees > 0 && _employees.isEmpty && !_isEmployeesLoading) {
          print('🔄 Stats show ${stats.allEmployees} employees, but list is empty. Loading employees...');
          _fetchEmployees();
        }
      } catch (e) {
        print('❌ Error in _fetchEmployeeStats: $e');
        setState(() {
          _employeeStats = EmployeeStats.empty();
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
 
 Future<void> _fetchAllEmployeeData() async {
  if (_organizationId == null || _organizationId == 0) {
    setState(() {
      _isEmployeesLoading = false;
    });
    return;
  }
  
  setState(() {
    _isEmployeesLoading = true;
  });
  
  try {
    // تحميل البيانات الأساسية
    final basicEmployees = await HRService.getEmployeesByOrgId(_organizationId!);
    
    if (basicEmployees.isEmpty) {
      setState(() {
        _employees = basicEmployees;
      });
    } else {
      // محاولة تحميل البيانات المالية
      final financialEmployees = await HRService.getEmployeeFinancialByOrgId(_organizationId!);
      
      if (financialEmployees.isNotEmpty) {
        // دمج البيانات
        _employees = _mergeEmployeeData(basicEmployees, financialEmployees);
      } else {
        // استخدام البيانات الأساسية فقط
        _employees = basicEmployees;
      }
    }
  } catch (e) {
    print('Error in _fetchAllEmployeeData: $e');
    setState(() {
      _employees = [];
    });
  } finally {
    setState(() {
      _isEmployeesLoading = false;
    });
  }
}
Future<void> _fetchAttendanceData() async {
  final employeeId = int.tryParse(widget.user?.employeeCode ?? '') ?? 0;
  if (employeeId == 0) {
    print('⚠️ No employee ID found for attendance');
    return;
  }

  try {
    setState(() {
      _isLoading = true;
    });

    final attendanceHistory = await AttendanceService.getAttendanceHistory(
      employeeId: employeeId,
      token: widget.user?.token,
    );

    if (attendanceHistory.isNotEmpty) {
      setState(() {
        _attendance = attendanceHistory;
      });
    }
  } catch (e) {
    print('❌ Error fetching attendance: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to load attendance data', 
                    style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


List<EmployeeModel> _mergeEmployeeData(
  List<EmployeeModel> basicEmployees,
  List<EmployeeModel> financialEmployees
) {
  return basicEmployees.map((basicEmployee) {
    // البحث عن الموظف المقابل في البيانات المالية باستخدام الـ ID
    try {
      final financialEmployee = financialEmployees.firstWhere(
        (emp) => emp.id == basicEmployee.id,
      );
      
      // دمج البيانات
      return EmployeeModel(
        id: basicEmployee.id,
        name: basicEmployee.name,
        position: basicEmployee.position,
        department: basicEmployee.department,
        status: basicEmployee.status,
        salary: basicEmployee.salary > 0 ? basicEmployee.salary : financialEmployee.basicSalary.toInt(),
        joinDate: basicEmployee.joinDate,
        basicSalary: financialEmployee.basicSalary,
        homeValueAlW: financialEmployee.homeValueAlW,
        travelValueAlW: financialEmployee.travelValueAlW,
        allValueAlW: financialEmployee.allValueAlW,
        sumAlWValue: financialEmployee.sumAlWValue,
        socialValueDeD: financialEmployee.socialValueDeD,
        allValueDeD: financialEmployee.allValueDeD,
        sumDeDValue: financialEmployee.sumDeDValue,
        sumAllValue: financialEmployee.sumAllValue,
      );
    } catch (e) {
      // إذا لم توجد بيانات مالية لهذا الموظف، ارجع البيانات الأساسية
      return basicEmployee;
    }
  }).toList();
}
  
  Future<void> _fetchEmployees() async {
    if (_organizationId == null) {
      setState(() {
        _isEmployeesLoading = false;
      });
      return;
    }
    
    setState(() {
      _isEmployeesLoading = true;
    });
    
    try {
      final employees = await HRService.getEmployeesByOrgId(_organizationId!);
      setState(() {
        _employees = employees;
      });
    } catch (e) {
      print('Error fetching employees: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load employees', 
                      style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isEmployeesLoading = false;
      });
    }
  }

  Future<void> _checkCurrentAttendanceStatus() async {
  try {
    if (widget.user?.employeeId == null) return;
    
    final todayAttendance = await AttendanceService.getTodayAttendance(
      widget.user!.employeeId!,
      token: widget.user?.token,
    );
    
    final firstStartTime = todayAttendance['firstStartTime'];
    
    if (firstStartTime != null && firstStartTime != '--') {
      setState(() {
        _isCheckedIn = true;
        // You might want to parse the time string to DateTime
        _lastCheckIn = DateTime.now();
      });
    }
    
    // Check break status
    final breakStartTime = todayAttendance['breakStartTime'];
    final breakEndTime = todayAttendance['breakEndTime'];
    
    if (breakStartTime != null && breakStartTime != '--' && 
        (breakEndTime == null || breakEndTime == '--')) {
      setState(() {
        _breakStatus = 'On Break';
      });
    }
  } catch (e) {
    print('❌ Error checking current attendance status: $e');
  }
}

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Core HR Functions
  void _showEmployeeDetails(EmployeeModel employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Employee Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Employee ID', employee.id),
              _buildDetailRow('Name', employee.name),
              _buildDetailRow('Position', employee.position),
              _buildDetailRow('Department', employee.department),
              _buildDetailRow('Status', employee.status),
              _buildDetailRow('Salary', '\$${employee.salary}'),
              _buildDetailRow('Join Date', employee.joinDate),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          if (_showEmployeeEditOptions)
            ElevatedButton(
              onPressed: () => _editEmployee(employee),
              child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
            ),
        ],
      ),
    );
  }

  void _editEmployee(EmployeeModel employee) {
    Navigator.pop(context); // إغلاق نافذة التفاصيل أولاً
    
    showDialog(
      context: context,
      builder: (context) => AddEmployeeDialog(
        employee: employee.toJson(),
        onEmployeeAdded: (updatedEmployee) {
          // هنا يجب إضافة منطق تحديث الموظف عبر الـ API
          setState(() {
            final index = _employees.indexWhere((e) => e.id == employee.id);
            if (index != -1) {
              _employees[index] = EmployeeModel.fromJson({
                ..._employees[index].toJson(),
                ...updatedEmployee,
              });
            }
          });
        },
      ),
    );
  }

  void _deleteEmployee(EmployeeModel employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Employee', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Are you sure you want to delete ${employee.name}?', style: TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _employees.removeWhere((e) => e.id == employee.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Employee deleted successfully', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddEmployeeDialog() {
    showDialog(
      context: context,
      builder: (context) => AddEmployeeDialog(
        onEmployeeAdded: (employee) {
          // تحويل Map إلى EmployeeModel
          final newEmployee = EmployeeModel.fromJson(employee);
          setState(() {
            _employees.add(newEmployee);
          });
        },
      ),
    );
  }

  // Attendance Functions
  Future<void> _checkIn() async {
  final now = DateTime.now();
  
  if (widget.user?.employeeId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Employee ID not found', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  try {
    final result = await AttendanceService.recordAttendance(
      employeeId: widget.user!.employeeId!,
      recordDateTime: now,
      dateType: AttendanceService.firstStartDateTime,
      token: widget.user?.token,
    );

    if (result['success'] == true) {
      setState(() {
        _isCheckedIn = true;
        _lastCheckIn = now;
      });
      
      // Refresh attendance data
      await _fetchAttendanceData();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Checked in successfully at ${_formatTime(now)}', 
                      style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to check in: ${result['message']}', 
                      style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error checking in: $e', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.red,
      ),
    );
  }
}
// Add this method with your other attendance methods
void _requestAbsence() {
  showDialog(
    context: context,
    builder: (context) => AbsenceRequestDialog(
      onAbsenceRequested: (absenceData) async {
        if (widget.user?.employeeId != null) {
          try {
            setState(() {
              _isLoading = true;
            });

            final result = await AttendanceService.recordAbsence(
              employeeId: widget.user!.employeeId!,
              absenceDate: DateTime.parse(absenceData['date']),
              reason: absenceData['reason'],
              managerId: absenceData['managerId'],
              token: widget.user?.token,
            );

            if (result['success'] == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Absence request submitted successfully', 
                              style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to submit absence: ${result['message']}', 
                              style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $e', style: TextStyle(fontFamily: 'Cairo')),
                backgroundColor: Colors.red,
              ),
            );
          } finally {
            setState(() {
              _isLoading = false;
            });
          }
        }
      },
    ),
  );
}

Future<void> _checkOut() async {
  final now = DateTime.now();
  
  if (widget.user?.employeeId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Employee ID not found', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  try {
    final result = await AttendanceService.recordAttendance(
      employeeId: widget.user!.employeeId!,
      recordDateTime: now,
      dateType: AttendanceService.firstEndDateTime,
      token: widget.user?.token,
    );

    if (result['success'] == true) {
      setState(() {
        _isCheckedIn = false;
      });
      
      // Refresh attendance data
      await _fetchAttendanceData();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Checked out successfully at ${_formatTime(now)}', 
                      style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.blue,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to check out: ${result['message']}', 
                      style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error checking out: $e', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> _startBreak() async {
  final now = DateTime.now();
  
  if (widget.user?.employeeId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Employee ID not found', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  try {
    final result = await AttendanceService.recordAttendance(
      employeeId: widget.user!.employeeId!,
      recordDateTime: now,
      dateType: AttendanceService.startBreakDateTime,
      token: widget.user?.token,
    );

    if (result['success'] == true) {
      setState(() {
        _breakStatus = 'On Break';
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Break started at ${_formatTime(now)}', 
                      style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.orange,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to start break: ${result['message']}', 
                      style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error starting break: $e', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> _endBreak() async {
  final now = DateTime.now();
  
  if (widget.user?.employeeId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Employee ID not found', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  try {
    final result = await AttendanceService.recordAttendance(
      employeeId: widget.user!.employeeId!,
      recordDateTime: now,
      dateType: AttendanceService.endBreakDateTime,
      token: widget.user?.token,
    );

    if (result['success'] == true) {
      setState(() {
        _breakStatus = 'Break Ended';
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Break ended at ${_formatTime(now)}', 
                      style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.purple,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to end break: ${result['message']}', 
                      style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error ending break: $e', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.red,
      ),
    );
  }
}

  // Leave Management Functions
  void _approveLeave(int index) {
    setState(() {
      _leaveRequests[index]['status'] = 'Approved';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Leave request approved for ${_leaveRequests[index]['employee']}', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _rejectLeave(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reject Leave Request', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Are you sure you want to reject the leave request for ${_leaveRequests[index]['employee']}?', 
                  style: TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _leaveRequests[index]['status'] = 'Rejected';
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Leave request rejected for ${_leaveRequests[index]['employee']}', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Reject', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLeaveRequestForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => LeaveRequestForm(
        onLeaveRequested: (request) {
          setState(() {
            _leaveRequests.add(request);
          });
        },
      ),
    );
  }

  void _showVocationRequestForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => VocationRequestForm(
        onVocationRequested: (request) {
          setState(() {
            _leaveRequests.add(request);
          });
        },
      ),
    );
  }

  // Payroll Functions
  void _showPayrollCalculator() {
    showDialog(
      context: context,
      builder: (context) => PayrollCalculatorDialog(
        onPayrollCalculated: (payrollData) {
          setState(() {
            _payrollRecords.insert(0, payrollData);
          });
        },
      ),
    );
  }


  // Utility Functions
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12;
    final period = date.hour < 12 ? 'AM' : 'PM';
    return '${hour == 0 ? 12 : hour}:${date.minute.toString().padLeft(2, '0')} $period';
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontFamily: 'Cairo')),
        ],
      ),
    );
  }

  // تصفية الموظفين بناءً على البحث
  List<EmployeeModel> get _filteredEmployees {
    if (_searchQuery.isEmpty) return _employees;
    return _employees.where((employee) =>
      employee.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      employee.position.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      employee.department.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

 // الحصول على إجمالي الرواتب الأساسية من البيانات المالية
int get _totalBasicSalary {
  return _employees.fold(0, (sum, employee) => sum + employee.basicSalary.toInt());
}

// الحصول على إجمالي البدلات
int get _totalAllowances {
  return _employees.fold(0, (sum, employee) => sum + employee.sumAlWValue.toInt());
}

// الحصول على إجمالي الاستقطاعات
int get _totalDeductions {
  return _employees.fold(0, (sum, employee) => sum + employee.sumDeDValue.toInt());
}

// الحصول على إجمالي صافي الرواتب
int get _totalNetSalaries {
  return _employees.fold(0, (sum, employee) => sum + employee.sumAllValue.toInt());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          'Human Resources Management',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.primaryColor.withOpacity(0.5),
          indicatorColor: AppColors.primaryColor,
          tabs: const [
            Tab(text: 'Dashboard'),
            Tab(text: 'Employees'),
            Tab(text: 'Attendance'),
            Tab(text: 'Payroll'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildEmployeesTab(),
          _buildAttendanceTab(),
          _buildPayrollTab(),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('HR Dashboard', 
                style: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _initializeData,
              tooltip: 'Refresh Dashboard',
            ),
          ],
        ),
        SizedBox(height: 16),
           // Stats section using GridView
        if (_isLoading)
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading statistics...',
                    style: TextStyle(fontFamily: 'Cairo'),
                  ),
                ],
              ),
            ),
          )
        else
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildStatCard(
                'Total Employees', 
                _employeeStats.allEmployees.toString(), 
                Colors.blue, 
                Icons.people
              ),
              _buildStatCard(
                'Present Today', 
                _employeeStats.attendanceToday.toString(), 
                Colors.green, 
                Icons.check_circle
              ),
              _buildStatCard(
                'On Leave', 
                _employeeStats.onLeave.toString(), 
                Colors.orange, 
                Icons.beach_access
              ),
              _buildStatCard(
                'Absent Today',
                _employeeStats.absentToday.toString(),
                Colors.purple,
                Icons.cancel
              ),
            ],
          ),
        
        SizedBox(height: 16),
          
          // Quick Actions
          Text('Quick Actions', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              if (_showAddEmployeeQuickAction)
                _buildActionButton('Add Employee', Icons.person_add, Colors.blue, _showAddEmployeeDialog),
              if (_showManageShiftAction)     
                _buildActionButton('Manage Shifts', Icons.schedule, Colors.green, _showShiftManagement),
              if (_showProcessPayrollAction)
                _buildActionButton('Process Payroll', Icons.attach_money, Colors.orange, _showPayrollCalculator),

              _buildActionButton('Leave Request', Icons.beach_access, Colors.purple, _showLeaveRequestForm),
              _buildActionButton('Vocation Request', Icons.flight_takeoff, Colors.yellow[700]!, _showVocationRequestForm),
              _buildAttendanceButton('Absence', Icons.person_off, Colors.red, _requestAbsence),
            ],
          ),

          // Recent Leave Requests
          SizedBox(height: 20),
          _buildRecentLeaveRequests(),
        ],
      ),
    );
  }

  Widget _buildEmployeesTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search employees...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: _showEmployeeFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: _isEmployeesLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: AppColors.primaryColor),
                      SizedBox(height: 16),
                      Text(
                        'Loading employees...',
                        style: TextStyle(fontFamily: 'Cairo'),
                      ),
                    ],
                  ),
                )
              : _filteredEmployees.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            _employees.isEmpty
                                ? 'No employees found'
                                : 'No results for "$_searchQuery"',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (_employees.isEmpty && !_isEmployeesLoading)
                            ElevatedButton(
                              onPressed: _fetchEmployees,
                              child: Text('Retry', style: TextStyle(fontFamily: 'Cairo')),
                            ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredEmployees.length,
                      itemBuilder: (context, index) {
                        final employee = _filteredEmployees[index];
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                              child: Icon(Icons.person, color: AppColors.primaryColor),
                            ),
                            title: Text(employee.name, style: TextStyle(fontFamily: 'Cairo')),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(employee.position, style: TextStyle(fontFamily: 'Cairo')),
                                Text(employee.department, 
                                     style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            trailing: PopupMenuButton(
                              itemBuilder: (context) {
                                List<PopupMenuItem> items = [
                                  PopupMenuItem(
                                    child: Text('View Details', style: TextStyle(fontFamily: 'Cairo')),
                                    onTap: () => _showEmployeeDetails(employee),
                                  ),
                                ];
                                
                                if (_showEmployeeEditOptions) {
                                  items.add(
                                    PopupMenuItem(
                                      child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
                                      onTap: () => _editEmployee(employee),
                                    ),
                                  );
                                }
                                
                                items.add(
                                  PopupMenuItem(
                                    child: Text('Delete', style: TextStyle(fontFamily: 'Cairo')),
                                    onTap: () => _deleteEmployee(employee),
                                  ),
                                );
                                
                                return items;
                              },
                            ),
                            onTap: () => _showEmployeeDetails(employee),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

 Widget _buildAttendanceTab() {
  final today = DateTime.now();
  final todayFormatted = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
  
  // Find today's record
  final todayRecord = _attendance.firstWhere(
    (record) => record['date'] == todayFormatted,
    orElse: () => {
      'date': todayFormatted,
      'firstStartTime': '--',
      'firstEndTime': '--',
      'breakStartTime': '--',
      'breakEndTime': '--',
      'status': 'Absent',
      'breaks': []
    },
  );

  return Column(
    children: [
      // Current Status Card
      Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Today\'s Status', 
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatusItem('Check In', todayRecord['firstStartTime'] ?? '--'),
                  _buildStatusItem('Check Out', todayRecord['firstEndTime'] ?? '--'),
                  _buildStatusItem('Break', _breakStatus),
                ],
              ),
              SizedBox(height: 8),
              if (_isCheckedIn)
                Text(
                  'Last check-in: ${_formatTime(_lastCheckIn)}',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildAttendanceButton(
                    'Check In', 
                    Icons.login, 
                    Colors.green, 
                    _isCheckedIn ? null : _checkIn
                  ),
                  _buildAttendanceButton(
                    'Check Out', 
                    Icons.logout, 
                    Colors.red, 
                    !_isCheckedIn ? null : _checkOut
                  ),
                  _buildAttendanceButton(
                    _breakStatus == 'On Break' ? 'End Break' : 'Start Break', 
                    Icons.free_breakfast, 
                    Colors.orange, 
                    _breakStatus == 'On Break' ? _endBreak : _startBreak
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Refresh button for attendance
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton.icon(
          onPressed: _fetchAttendanceData,
          icon: Icon(Icons.refresh),
          label: Text('Refresh Attendance', style: TextStyle(fontFamily: 'Cairo')),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 40),
          ),
        ),
      ),

      // Attendance History
      Expanded(
        child: _isLoading
            ? Center(child: CircularProgressIndicator(color: AppColors.primaryColor))
            : ListView.builder(
                itemCount: _attendance.length,
                itemBuilder: (context, index) {
                  final record = _attendance[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: ListTile(
                      leading: Icon(
                        record['status'] == 'Present' ? Icons.check_circle : 
                        record['status'] == 'Absent' ? Icons.cancel : Icons.watch_later,
                        color: record['status'] == 'Present' ? Colors.green : 
                               record['status'] == 'Absent' ? Colors.red : Colors.orange,
                      ),
                      title: Text(record['date'], style: TextStyle(fontFamily: 'Cairo')),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('In: ${record['firstStartTime']} - Out: ${record['firstEndTime']}', 
                              style: TextStyle(fontFamily: 'Cairo')),
                          if (record['breakStartTime'] != '--')
                            Text('Break: ${record['breakStartTime']} - ${record['breakEndTime']}', 
                                style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      trailing: Text(record['status'] ?? 'N/A', style: TextStyle(
                        color: record['status'] == 'Present' ? Colors.green : 
                               record['status'] == 'Absent' ? Colors.red : Colors.orange,
                        fontFamily: 'Cairo'
                      )),
                    ),
                  );
                },
              ),
      ),
    ],
  );
}

  Widget _buildPayrollTab() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان ومعلومات التزامن
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payroll Management', 
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  '${_employees.length} employees • Updated: ${_formatDate(DateTime.now())}',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _initializeData,
              tooltip: 'Refresh Payroll Data',
            ),
          ],
        ),
        
        SizedBox(height: 20),
        
        // معلومات التزامن
        if (_employees.isEmpty)
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange),
            ),
            child: Column(
              children: [
                Icon(Icons.warning, color: Colors.orange, size: 32),
                SizedBox(height: 12),
                Text(
                  'No employee data available',
                  style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Load employees to view payroll information',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _initializeData,
                  child: Text('Load Employees', style: TextStyle(fontFamily: 'Cairo')),
                ),
              ],
            ),
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // إشعار التزامن
              if (_employeeStats.allEmployees > 0 && _employees.length != _employeeStats.allEmployees)
                Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.sync, color: Colors.blue, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Data synchronized with dashboard. Using ${_employees.length} actual employees.',
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.blue[800]),
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Totals Section
              Text('Payroll Totals', 
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              
              // Totals Grid
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.5,
                children: [
                  _buildTotalItem('Total Basic Salary', '\$$_totalBasicSalary', Colors.blue, Icons.money),
                  _buildTotalItem('Total Allowances', '\$$_totalAllowances', Colors.green, Icons.add_circle),
                  _buildTotalItem('Total Deductions', '\$$_totalDeductions', Colors.orange, Icons.remove_circle),
                  _buildTotalItem('Total Net Salaries', '\$$_totalNetSalaries', Colors.purple, Icons.account_balance_wallet),
                ],
              ),

              // Employee Salary Details
              SizedBox(height: 32),
              _buildEmployeePayrollTable(),
              
              // ملخص التطابق
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Data Consistency',
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey[600]),
                        ),
                        Text(
                          '${_employees.length} employees processed',
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Financial Data',
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey[600]),
                        ),
                        Text(
                          '${_employees.where((e) => e.basicSalary > 0).length} available',
                          style: TextStyle(
                            fontFamily: 'Cairo', 
                            fontSize: 14, 
                            fontWeight: FontWeight.bold,
                            color: _employees.where((e) => e.basicSalary > 0).length == _employees.length 
                              ? Colors.green 
                              : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    ),
  );
}

Widget _buildTotalItem(String label, String value, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.05),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.1)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        SizedBox(width: 12),
       Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, 
                  style: TextStyle(
                    fontFamily: 'Cairo', 
                    fontSize: 11, // Smaller font
                    color: Colors.grey[600],
                  ),
                  maxLines: 2, // Allow text to wrap
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: 4),
              Text(value, 
                  style: TextStyle(
                    fontFamily: 'Cairo', 
                    fontSize: 16, // Slightly smaller
                    fontWeight: FontWeight.bold, 
                    color: color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    ),
  );
}


  // Helper Widgets
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(height: 8),
              Text(value, style: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold)),
              Text(title, style: TextStyle(fontFamily: 'Cairo', color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceButton(String text, IconData icon, Color color, VoidCallback? onPressed) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          radius: 30,
          child: IconButton(
            icon: Icon(icon, color: color),
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 8),
        Text(text, style: TextStyle(fontFamily: 'Cairo')),
      ],
    );
  }

  Widget _buildStatusItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
        Text(value, style: TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
  Widget _buildRecentLeaveRequests() {
    final pendingLeaves = _leaveRequests.where((leave) => leave['status'] == 'Pending').take(3).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pending Leave Requests', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                if (pendingLeaves.isNotEmpty)
                  Chip(
                    label: Text('${pendingLeaves.length} pending', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                    backgroundColor: Colors.orange,
                  ),
              ],
            ),
            SizedBox(height: 12),
            ...pendingLeaves.asMap().entries.map((entry) {
              final index = _leaveRequests.indexWhere((l) => l['id'] == entry.value['id']);
              return _buildLeaveRequestItem(entry.value, index);
            }),
            if (pendingLeaves.isEmpty)
              Text('No pending leave requests', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveRequestItem(Map<String, dynamic> leave, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(
          leave['status'] == 'Approved' ? Icons.check_circle : 
          leave['status'] == 'Rejected' ? Icons.cancel : Icons.pending,
          color: leave['status'] == 'Approved' ? Colors.green : 
                 leave['status'] == 'Rejected' ? Colors.red : Colors.orange,
        ),
        title: Text(leave['employee'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${leave['type']}', style: TextStyle(fontFamily: 'Cairo')),
            Text('${leave['from']} to ${leave['to']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
            if (leave['reason'] != null)
              Text('Reason: ${leave['reason']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 11, color: Colors.grey)),
          ],
        ),
        trailing: leave['status'] == 'Pending' ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check, color: Colors.green),
              onPressed: () => _approveLeave(index),
              tooltip: 'Approve Leave',
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () => _rejectLeave(index),
              tooltip: 'Reject Leave',
            ),
          ],
        ) : Text(leave['status'], style: TextStyle(
          fontFamily: 'Cairo',
          color: leave['status'] == 'Approved' ? Colors.green : 
                 leave['status'] == 'Rejected' ? Colors.red : Colors.orange,
        )),
      ),
    );
  }

 Widget _buildEmployeePayrollTable() {
  if (_employees.isEmpty) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          'No employee data available',
          style: TextStyle(fontFamily: 'Cairo', color: Colors.grey[600]),
        ),
      ),
    );
  }

  return Card(
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          // Table Header
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text('Employee', 
                        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.normal)),
                  ),
                  Expanded(
                    child: Text('Basic Salary', 
                        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('Allowances', 
                        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('Deductions', 
                        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('Net Salary', 
                        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
          
          // Table Rows
          ..._employees.map((employee) {
            // استخدام البيانات المالية من الـ API
            final basicSalary = employee.basicSalary;
            final allowances = employee.sumAlWValue;
            final deductions = employee.sumDeDValue;
            final netSalary = employee.sumAllValue;

            return Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(employee.name,
                              style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500)),
                          Text(employee.position,
                              style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text('\$${basicSalary.toStringAsFixed(0)}',
                          style: TextStyle(fontFamily: 'Cairo'),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text('\$${allowances.toStringAsFixed(0)}',
                          style: TextStyle(fontFamily: 'Cairo', color: Colors.green),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text('\$${deductions.toStringAsFixed(0)}',
                          style: TextStyle(fontFamily: 'Cairo', color: Colors.orange),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text('\$${netSalary.toStringAsFixed(0)}',
                          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: Colors.purple),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            );
          }),
          
          // Table Footer (Totals Row)
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text('Total', 
                        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Text(
                      '\$${_employees.fold(0, (sum, employee) => sum + employee.basicSalary.toInt())}',
                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '\$${_employees.fold(0, (sum, employee) => sum + employee.sumAlWValue.toInt())}',
                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '\$${_employees.fold(0, (sum, employee) => sum + employee.sumDeDValue.toInt())}',
                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: Colors.orange),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '\$${_employees.fold(0, (sum, employee) => sum + employee.sumAllValue.toInt())}',
                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: Colors.purple),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  void _showEmployeeFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Employees', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filter functionality to be implemented', style: TextStyle(fontFamily: 'Cairo')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _showShiftManagement() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ShiftManagementSheet(),
    );
  }
}

// Interactive Dialogs and Sheets
class AddEmployeeDialog extends StatefulWidget {
  final Map<String, dynamic>? employee;
  final Function(Map<String, dynamic>) onEmployeeAdded;

  const AddEmployeeDialog({super.key, this.employee, required this.onEmployeeAdded});

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _departmentController = TextEditingController();
  final _salaryController = TextEditingController();
  String _selectedStatus = 'Active';

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _nameController.text = widget.employee!['name'];
      _positionController.text = widget.employee!['position'];
      _departmentController.text = widget.employee!['department'];
      _salaryController.text = widget.employee!['salary'].toString();
      _selectedStatus = widget.employee!['status'];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _departmentController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.employee == null ? 'Add New Employee' : 'Edit Employee', 
                style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Please enter name' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _positionController,
                decoration: InputDecoration(labelText: 'Position'),
                validator: (value) => value!.isEmpty ? 'Please enter position' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _departmentController,
                decoration: InputDecoration(labelText: 'Department'),
                validator: (value) => value!.isEmpty ? 'Please enter department' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter salary' : null,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField(
                initialValue: _selectedStatus,
                items: ['Active', 'On Leave', 'Inactive']
                    .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedStatus = value!),
                decoration: InputDecoration(labelText: 'Status'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newEmployee = {
                'id': widget.employee?['id'] ?? '00${DateTime.now().millisecondsSinceEpoch}',
                'name': _nameController.text,
                'position': _positionController.text,
                'department': _departmentController.text,
                'salary': int.parse(_salaryController.text),
                'status': _selectedStatus,
                'joinDate': widget.employee?['joinDate'] ?? _formatDate(DateTime.now()),
              };
              
              widget.onEmployeeAdded(newEmployee);
              Navigator.pop(context);
            }
          },
          child: Text(widget.employee == null ? 'Add Employee' : 'Update Employee', 
                    style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class ShiftManagementSheet extends StatelessWidget {
  const ShiftManagementSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Shift Management', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          _buildShiftCard('Morning Shift', '08:00 AM - 05:00 PM', Colors.blue),
          _buildShiftCard('Evening Shift', '04:00 PM - 01:00 AM', Colors.orange),
          _buildShiftCard('Night Shift', '10:00 PM - 07:00 AM', Colors.purple),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement shift management logic here
              Navigator.pop(context);
            },
            child: Text('Manage Shifts', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(String name, String time, Color color) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.schedule, color: color),
        title: Text(name, style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Text(time, style: TextStyle(fontFamily: 'Cairo')),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

class PayrollCalculatorDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onPayrollCalculated;

  const PayrollCalculatorDialog({super.key, required this.onPayrollCalculated});

  @override
  State<PayrollCalculatorDialog> createState() => _PayrollCalculatorDialogState();
}

class _PayrollCalculatorDialogState extends State<PayrollCalculatorDialog> {
  final _basicSalaryController = TextEditingController();
  final _allowancesController = TextEditingController();
  final _deductionsController = TextEditingController();
  double _netSalary = 0;

  @override
  void dispose() {
    _basicSalaryController.dispose();
    _allowancesController.dispose();
    _deductionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Payroll Calculator', style: TextStyle(fontFamily: 'Cairo')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _basicSalaryController,
            decoration: InputDecoration(labelText: 'Basic Salary'),
            keyboardType: TextInputType.number,
            onChanged: _calculateNetSalary,
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: _allowancesController,
            decoration: InputDecoration(labelText: 'Allowances'),
            keyboardType: TextInputType.number,
            onChanged: _calculateNetSalary,
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: _deductionsController,
            decoration: InputDecoration(labelText: 'Deductions'),
            keyboardType: TextInputType.number,
            onChanged: _calculateNetSalary,
          ),
          SizedBox(height: 16),
          Card(
            color: Colors.green[50],
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Net Salary: \$$_netSalary', 
                style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
        ),
        ElevatedButton(
          onPressed: () {
            final basic = double.tryParse(_basicSalaryController.text) ?? 0;
            final allowances = double.tryParse(_allowancesController.text) ?? 0;
            final deductions = double.tryParse(_deductionsController.text) ?? 0;
            
            widget.onPayrollCalculated({
              'period': '${DateTime.now().month}/${DateTime.now().year}',
              'basicSalary': basic,
              'allowances': allowances,
              'deductions': deductions,
              'netSalary': _netSalary,
              'status': 'Pending'
            });
            Navigator.pop(context);
          },
          child: Text('Calculate', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  void _calculateNetSalary(String value) {
    final basic = double.tryParse(_basicSalaryController.text) ?? 0;
    final allowances = double.tryParse(_allowancesController.text) ?? 0;
    final deductions = double.tryParse(_deductionsController.text) ?? 0;
    
    setState(() {
      _netSalary = basic + allowances - deductions;
    });
  }
}

class LeaveRequestForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onLeaveRequested;

  const LeaveRequestForm({super.key, required this.onLeaveRequested});
  
  @override
  State<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'Annual Leave';
  DateTime? _fromDate;
  DateTime? _toDate;
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Request Leave', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  initialValue: _selectedType,
                  items: ['Annual Leave', 'Sick Leave', 'Emergency Leave', 'Maternity Leave']
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedType = value!),
                  decoration: InputDecoration(labelText: 'Leave Type'),
                ),
                SizedBox(height: 12),
                ListTile(
                  title: Text(_fromDate == null ? 'Select From Date' : 'From: ${_formatDate(_fromDate!)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                    );
                    if (date != null) setState(() => _fromDate = date);
                  },
                ),
                ListTile(
                  title: Text(_toDate == null ? 'Select To Date' : 'To: ${_formatDate(_toDate!)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _fromDate ?? DateTime.now(),
                      firstDate: _fromDate ?? DateTime.now(),
                      lastDate: DateTime(2025),
                    );
                    if (date != null) setState(() => _toDate = date);
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _reasonController,
                  decoration: InputDecoration(
                    labelText: 'Reason',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) => value!.isEmpty ? 'Please enter reason' : null,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate() && _fromDate != null && _toDate != null) {
                widget.onLeaveRequested({
                  'id': 'L${DateTime.now().millisecondsSinceEpoch}',
                  'employee': 'Current User',
                  'type': _selectedType,
                  'from': _formatDate(_fromDate!),
                  'to': _formatDate(_toDate!),
                  'reason': _reasonController.text,
                  'status': 'Pending'
                });
                Navigator.pop(context);
              }
            },
            child: Text('Submit Request', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class VocationRequestForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onVocationRequested;

  const VocationRequestForm({super.key, required this.onVocationRequested});
  
  @override
  State<VocationRequestForm> createState() => _VocationRequestFormState();
}

class _VocationRequestFormState extends State<VocationRequestForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _fromDate;
  DateTime? _toDate;
  final _destinationController = TextEditingController();
  final _reasonController = TextEditingController();

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Request Vocation', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                ListTile(
                  title: Text(_fromDate == null ? 'Select Start Date' : 'From: ${_formatDate(_fromDate!)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                    );
                    if (date != null) setState(() => _fromDate = date);
                  },
                ),
                ListTile(
                  title: Text(_toDate == null ? 'Select End Date' : 'To: ${_formatDate(_toDate!)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _fromDate ?? DateTime.now(),
                      firstDate: _fromDate ?? DateTime.now(),
                      lastDate: DateTime(2025),
                    );
                    if (date != null) setState(() => _toDate = date);
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _destinationController,
                  decoration: InputDecoration(
                    labelText: 'Destination',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter destination' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _reasonController,
                  decoration: InputDecoration(
                    labelText: 'Reason for Vocation',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) => value!.isEmpty ? 'Please enter reason' : null,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate() && _fromDate != null && _toDate != null) {
                widget.onVocationRequested({
                  'id': 'V${DateTime.now().millisecondsSinceEpoch}',
                  'employee': 'Current User',
                  'type': 'Vocation',
                  'from': _formatDate(_fromDate!),
                  'to': _formatDate(_toDate!),
                  'destination': _destinationController.text,
                  'reason': _reasonController.text,
                  'status': 'Pending'
                });
                Navigator.pop(context);
              }
            },
            child: Text('Submit Vocation Request', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }
}

class AbsenceRequestDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onAbsenceRequested;

  const AbsenceRequestDialog({super.key, required this.onAbsenceRequested});

  @override
  State<AbsenceRequestDialog> createState() => _AbsenceRequestDialogState();
}

class _AbsenceRequestDialogState extends State<AbsenceRequestDialog> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _absenceDate;
  final _reasonController = TextEditingController();
  final _managerIdController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    _managerIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Request Absence', style: TextStyle(fontFamily: 'Cairo')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  _absenceDate == null 
                    ? 'Select Absence Date' 
                    : 'Date: ${_formatDate(_absenceDate!)}',
                  style: TextStyle(fontFamily: 'Cairo'),
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)), // Allow past dates
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() => _absenceDate = date);
                  }
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _managerIdController,
                decoration: InputDecoration(
                  labelText: 'Manager ID (Optional)',
                  hintText: 'Enter manager ID if required',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: 'Reason for Absence*',
                  hintText: 'e.g., Sick, Personal, Vacation, ADS',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Please enter reason' : null,
              ),
              SizedBox(height: 8),
              Text(
                'Note: Use "ADS" for approved absence (as per API)',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() && _absenceDate != null) {
              widget.onAbsenceRequested({
                'date': _formatDate(_absenceDate!),
                'reason': _reasonController.text,
                'managerId': _managerIdController.text.isNotEmpty 
                  ? int.tryParse(_managerIdController.text) 
                  : null,
              });
              Navigator.pop(context);
            }
          },
          child: Text('Submit Request', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}