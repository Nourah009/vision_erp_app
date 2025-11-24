import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';

class HumanResourcesPage extends StatefulWidget {
  final UserModel? user;
  
  const HumanResourcesPage({super.key, this.user});

  @override
  State<HumanResourcesPage> createState() => _HumanResourcesPageState();
}

class _HumanResourcesPageState extends State<HumanResourcesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  DateTime _lastCheckIn = DateTime.now();
  bool _isCheckedIn = false;
  String _breakStatus = 'No Break'; // 'No Break', 'On Break', 'Break Ended'

  // Sample data for demonstration
  final List<Map<String, dynamic>> _employees = [
    {'id': '001', 'name': 'Ahmed Mohamed', 'position': 'Software Developer', 'department': 'IT', 'status': 'Active', 'salary': 5000, 'joinDate': '2023-01-15'},
    {'id': '002', 'name': 'Sarah Ahmed', 'position': 'HR Manager', 'department': 'HR', 'status': 'Active', 'salary': 7000, 'joinDate': '2022-03-10'},
    {'id': '003', 'name': 'Yasser Ali', 'position': 'Sales Executive', 'department': 'Sales', 'status': 'On Leave', 'salary': 4500, 'joinDate': '2023-06-20'},
  ];

  final List<Map<String, dynamic>> _attendance = [
    {'date': '2024-01-15', 'checkIn': '08:00 AM', 'checkOut': '05:00 PM', 'status': 'Present', 'breaks': []},
    {'date': '2024-01-14', 'checkIn': '08:15 AM', 'checkOut': '05:30 PM', 'status': 'Present', 'breaks': []},
    {'date': '2024-01-13', 'checkIn': '--', 'checkOut': '--', 'status': 'Absent', 'breaks': []},
  ];

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

  final List<Map<String, dynamic>> _jobOpenings = [
    {'id': 'J001', 'title': 'Senior Flutter Developer', 'department': 'IT', 'location': 'Riyadh', 'type': 'Full-time', 'status': 'Open', 'applicants': 5},
    {'id': 'J002', 'title': 'HR Specialist', 'department': 'Human Resources', 'location': 'Jeddah', 'type': 'Full-time', 'status': 'Open', 'applicants': 3},
    {'id': 'J003', 'title': 'Sales Manager', 'department': 'Sales', 'location': 'Dubai', 'type': 'Full-time', 'status': 'Closed', 'applicants': 8},
  ];

  List<Map<String, dynamic>> _trainingCourses = [
    {'id': 'T001', 'title': 'Leadership Skills', 'duration': '2 weeks', 'level': 'Advanced', 'instructor': 'Dr. Smith', 'enrolled': 15, 'capacity': 20, 'status': 'Active'},
    {'id': 'T002', 'title': 'Project Management', 'duration': '4 weeks', 'level': 'Intermediate', 'instructor': 'Prof. Ahmed', 'enrolled': 12, 'capacity': 25, 'status': 'Active'},
    {'id': 'T003', 'title': 'Communication Skills', 'duration': '1 week', 'level': 'Beginner', 'instructor': 'Ms. Davis', 'enrolled': 20, 'capacity': 20, 'status': 'Full'},
  ];

  List<Map<String, dynamic>> _recruitmentPipeline = [
    {'id': 'C001', 'name': 'Salem Abullatif', 'position': 'Senior Flutter Developer', 'stage': 'Applied', 'appliedDate': '2024-01-10', 'score': 0},
    {'id': 'C002', 'name': 'Abdullah Bader', 'position': 'HR Specialist', 'stage': 'Screening', 'appliedDate': '2024-01-12', 'score': 75},
    {'id': 'C003', 'name': 'Samer Ali', 'position': 'Senior Flutter Developer', 'stage': 'Interview', 'appliedDate': '2024-01-08', 'score': 82},
    {'id': 'C004', 'name': 'Ali Naif', 'position': 'Sales Manager', 'stage': 'Offer', 'appliedDate': '2024-01-05', 'score': 88},
  ];

  final List<Map<String, dynamic>> _performanceReviews = [
    {'employee': 'Ahmed Mohamed', 'period': 'Q4 2023', 'rating': 4.5, 'comments': 'Excellent performance with outstanding project delivery', 'reviewer': 'Sarah Ahmed'},
    {'employee': 'Yasser Ali', 'period': 'Q4 2023', 'rating': 3.8, 'comments': 'Good overall performance with strong sales results', 'reviewer': 'Sarah Ahmed'},
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _checkCurrentAttendanceStatus();
  }

  void _checkCurrentAttendanceStatus() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // Check if user has already checked in today
    final todayRecord = _attendance.firstWhere(
      (record) => record['date'] == _formatDate(today),
      orElse: () => {},
    );
    
    if (todayRecord.isNotEmpty && todayRecord['checkIn'] != '--') {
      setState(() {
        _isCheckedIn = true;
        _lastCheckIn = DateTime.now();
      });
    }
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTabIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Core HR Functions
  void _showEmployeeDetails(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Employee Details', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Employee ID', employee['id']),
              _buildDetailRow('Name', employee['name']),
              _buildDetailRow('Position', employee['position']),
              _buildDetailRow('Department', employee['department']),
              _buildDetailRow('Status', employee['status']),
              _buildDetailRow('Salary', '\$${employee['salary']}'),
              _buildDetailRow('Join Date', employee['joinDate']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => _editEmployee(employee),
            child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _editEmployee(Map<String, dynamic> employee) {
    Navigator.pop(context); // Close details dialog first
    
    showDialog(
      context: context,
      builder: (context) => AddEmployeeDialog(
        employee: employee,
        onEmployeeAdded: (updatedEmployee) {
          setState(() {
            final index = _employees.indexWhere((e) => e['id'] == employee['id']);
            if (index != -1) {
              _employees[index] = {..._employees[index], ...updatedEmployee};
            }
          });
        },
      ),
    );
  }

  void _deleteEmployee(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Employee', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Are you sure you want to delete ${employee['name']}?', style: TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _employees.removeWhere((e) => e['id'] == employee['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Employee deleted successfully', style: TextStyle(fontFamily: 'Cairo'))),
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
          setState(() {
            _employees.add(employee);
          });
        },
      ),
    );
  }

  // Attendance Functions
  void _checkIn() {
    final now = DateTime.now();
    final today = _formatDate(now);
    
    setState(() {
      _isCheckedIn = true;
      _lastCheckIn = now;
      
      // Add or update attendance record
      final existingIndex = _attendance.indexWhere((record) => record['date'] == today);
      if (existingIndex != -1) {
        _attendance[existingIndex]['checkIn'] = _formatTime(now);
        _attendance[existingIndex]['status'] = 'Present';
      } else {
        _attendance.insert(0, {
          'date': today,
          'checkIn': _formatTime(now),
          'checkOut': '--',
          'status': 'Present',
          'breaks': []
        });
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Checked in at ${_formatTime(now)}', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _checkOut() {
    final now = DateTime.now();
    final today = _formatDate(now);
    
    setState(() {
      _isCheckedIn = false;
      
      final existingIndex = _attendance.indexWhere((record) => record['date'] == today);
      if (existingIndex != -1) {
        _attendance[existingIndex]['checkOut'] = _formatTime(now);
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Checked out at ${_formatTime(now)}', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _startBreak() {
    final now = DateTime.now();
    final today = _formatDate(now);
    
    setState(() {
      _breakStatus = 'On Break';
      
      final existingIndex = _attendance.indexWhere((record) => record['date'] == today);
      if (existingIndex != -1) {
        _attendance[existingIndex]['breaks'].add({
          'start': _formatTime(now),
          'end': '--'
        });
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Break started at ${_formatTime(now)}', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _endBreak() {
    final now = DateTime.now();
    final today = _formatDate(now);
    
    setState(() {
      _breakStatus = 'Break Ended';
      
      final existingIndex = _attendance.indexWhere((record) => record['date'] == today);
      if (existingIndex != -1 && _attendance[existingIndex]['breaks'].isNotEmpty) {
        final lastBreak = _attendance[existingIndex]['breaks'].last;
        if (lastBreak['end'] == '--') {
          lastBreak['end'] = _formatTime(now);
        }
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Break ended at ${_formatTime(now)}', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.purple,
      ),
    );
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

  void _processPayroll(int index) {
    setState(() {
      _payrollRecords[index]['status'] = 'Processed';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payroll processed for ${_payrollRecords[index]['period']}', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Recruitment Functions
  void _showRecruitmentPipeline() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecruitmentPipelinePage(
          pipeline: _recruitmentPipeline,
          onCandidateUpdated: (updatedPipeline) {
            setState(() {
              _recruitmentPipeline = updatedPipeline;
            });
          },
        ),
      ),
    );
  }

  void _applyForJob(Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (context) => JobApplicationDialog(
        job: job,
        onApplicationSubmitted: (application) {
          setState(() {
            _recruitmentPipeline.add({
              'id': 'C${_recruitmentPipeline.length + 1}'.padLeft(3, '0'),
              'name': application['name'],
              'position': job['title'],
              'stage': 'Applied',
              'appliedDate': _formatDate(DateTime.now()),
              'score': 0
            });
            job['applicants'] = (job['applicants'] as int) + 1;
          });
        },
      ),
    );
  }

  // Training Functions
  void _showTrainingManagement() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingManagementPage(
          courses: _trainingCourses,
          onCourseUpdated: (updatedCourses) {
            setState(() {
              _trainingCourses = updatedCourses;
            });
          },
        ),
      ),
    );
  }

  void _enrollInTraining(Map<String, dynamic> course) {
    if (course['enrolled'] >= course['capacity']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Course is full!', style: TextStyle(fontFamily: 'Cairo')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enroll in Course', style: TextStyle(fontFamily: 'Cairo')),
        content: Text('Are you sure you want to enroll in ${course['title']}?', style: TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                course['enrolled'] = course['enrolled'] + 1;
                if (course['enrolled'] >= course['capacity']) {
                  course['status'] = 'Full';
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Successfully enrolled in ${course['title']}', style: TextStyle(fontFamily: 'Cairo')),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Enroll', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  // Performance Management
  void _showPerformanceReview() {
    showDialog(
      context: context,
      builder: (context) => PerformanceReviewDialog(
        employees: _employees.where((e) => e['status'] == 'Active').toList(),
        onReviewSubmitted: (review) {
          setState(() {
            _performanceReviews.add(review);
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

  Color _getRatingColor(double rating) {
    if (rating >= 4.0) return Colors.green;
    if (rating >= 3.0) return Colors.orange;
    return Colors.red;
  }

  // Filtered data based on search
  List<Map<String, dynamic>> get _filteredEmployees {
    if (_searchQuery.isEmpty) return _employees;
    return _employees.where((employee) =>
      employee['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      employee['position'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      employee['department'].toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
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
            Tab(text: 'Recruitment'),
            Tab(text: 'Training'),
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
          _buildRecruitmentTab(),
          _buildTrainingTab(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDashboardTab() {
    final totalEmployees = _employees.length;
    final presentToday = _attendance.where((a) => a['date'] == _formatDate(DateTime.now()) && a['status'] == 'Present').length;
    final onLeave = _leaveRequests.where((l) => l['status'] == 'Approved').length;
    final int() = _jobOpenings.where((j) => j['status'] == 'Open').length;
    final averagePerformance = _performanceReviews.isNotEmpty 
        ? _performanceReviews.map((r) => r['rating']).reduce((a, b) => a + b) / _performanceReviews.length
        : 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Quick Stats
          Row(
            children: [
              _buildStatCard('Total Employees', totalEmployees.toString(), Colors.blue, Icons.people),
              SizedBox(width: 12),
              _buildStatCard('Present Today', presentToday.toString(), Colors.green, Icons.check_circle),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('On Leave', onLeave.toString(), Colors.orange, Icons.beach_access),
              SizedBox(width: 12),
              _buildStatCard('Avg Performance', averagePerformance.toStringAsFixed(1), Colors.teal, Icons.assessment),
            ],
          ),
          SizedBox(height: 20),

          // Quick Actions
          Text('Quick Actions', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildActionButton('Add Employee', Icons.person_add, Colors.blue, _showAddEmployeeDialog),
              _buildActionButton('Manage Shifts', Icons.schedule, Colors.green, _showShiftManagement),
              _buildActionButton('Process Payroll', Icons.attach_money, Colors.orange, _showPayrollCalculator),
              _buildActionButton('Request Leave', Icons.beach_access, Colors.purple, _showLeaveRequestForm),
              _buildActionButton('Training', Icons.school, Colors.brown, _showTrainingManagement),
              _buildActionButton('Recruitment', Icons.work, Colors.red, _showRecruitmentPipeline),
              _buildActionButton('Performance', Icons.assessment, Colors.teal, _showPerformanceReview),
            ],
          ),

          // Recent Leave Requests with Approve/Reject buttons
          SizedBox(height: 20),
          _buildRecentLeaveRequests(),

          // Performance Reviews Section
          SizedBox(height: 20),
          _buildRecentPerformanceReviews(),
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
          child: ListView.builder(
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
                  title: Text(employee['name'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Text('${employee['position']} - ${employee['department']}', style: TextStyle(fontFamily: 'Cairo')),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('View Details', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _showEmployeeDetails(employee),
                      ),
                      PopupMenuItem(
                        child: Text('Edit', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _editEmployee(employee),
                      ),
                      PopupMenuItem(
                        child: Text('Delete', style: TextStyle(fontFamily: 'Cairo')),
                        onTap: () => _deleteEmployee(employee),
                      ),
                    ],
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
    final todayRecord = _attendance.firstWhere(
      (record) => record['date'] == _formatDate(DateTime.now()),
      orElse: () => {'checkIn': '--', 'checkOut': '--', 'status': 'Absent'},
    );

    return Column(
      children: [
        // Current Status Card with last check-in time
        Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Today\'s Status', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatusItem('Check In', todayRecord['checkIn']),
                    _buildStatusItem('Check Out', todayRecord['checkOut']),
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
                    _buildAttendanceButton('Check In', Icons.login, Colors.green, _isCheckedIn ? null : _checkIn),
                    _buildAttendanceButton('Check Out', Icons.logout, Colors.red, !_isCheckedIn ? null : _checkOut),
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

        // Attendance History
        Expanded(
          child: ListView.builder(
            itemCount: _attendance.length,
            itemBuilder: (context, index) {
              final record = _attendance[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: Icon(
                    record['status'] == 'Present' ? Icons.check_circle : Icons.cancel,
                    color: record['status'] == 'Present' ? Colors.green : Colors.red,
                  ),
                  title: Text(record['date'], style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${record['checkIn']} - ${record['checkOut']}', style: TextStyle(fontFamily: 'Cairo')),
                      if (record['breaks'] != null && record['breaks'].isNotEmpty)
                        Text('Breaks: ${record['breaks'].length}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  trailing: Text(record['status'], style: TextStyle(
                    color: record['status'] == 'Present' ? Colors.green : Colors.red,
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
        children: [
          ..._payrollRecords.asMap().entries.map((entry) {
            final index = entry.key;
            final record = entry.value;
            return _buildPayrollCard(record, index);
          }),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _showPayrollCalculator,
            icon: Icon(Icons.calculate),
            label: Text('Calculate Payroll', style: TextStyle(fontFamily: 'Cairo')),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecruitmentTab() {
    final openJobs = _jobOpenings.where((job) => job['status'] == 'Open').toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Open Positions', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ...openJobs.map((job) => _buildJobCard(job)),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              onPressed: _showRecruitmentPipeline,
              icon: Icon(Icons.visibility),
              label: Text('View Recruitment Pipeline', style: TextStyle(fontFamily: 'Cairo')),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Available Courses', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._trainingCourses.map((course) => _buildTrainingCard(course)),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              onPressed: _showTrainingManagement,
              icon: Icon(Icons.school),
              label: Text('Manage Training', style: TextStyle(fontFamily: 'Cairo')),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_selectedTabIndex) {
      case 1: // Employees
        return FloatingActionButton(
          onPressed: _showAddEmployeeDialog,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.person_add, color: Colors.white),
        );
      case 2: // Attendance
        return FloatingActionButton(
          onPressed: _isCheckedIn ? _checkOut : _checkIn,
          backgroundColor: _isCheckedIn ? Colors.red : Colors.green,
          child: Icon(_isCheckedIn ? Icons.logout : Icons.login, color: Colors.white),
        );
      case 3: // Payroll
        return FloatingActionButton(
          onPressed: _showPayrollCalculator,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.attach_money, color: Colors.white),
        );
      case 4: // Recruitment
        return FloatingActionButton(
          onPressed: _showRecruitmentPipeline,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.work, color: Colors.white),
        );
      case 5: // Training
        return FloatingActionButton(
          onPressed: _showTrainingManagement,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
      default:
        return FloatingActionButton(
          onPressed: _showLeaveRequestForm,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        );
    }
  }

  // Helper Widgets
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildPayrollCard(Map<String, dynamic> record, int index) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.attach_money, color: AppColors.primaryColor),
        title: Text(record['period'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Net Salary: \$${record['netSalary']}', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            Text('Basic: \$${record['basicSalary']} | Allowances: \$${record['allowances']} | Deductions: \$${record['deductions']}', 
              style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: record['status'] == 'Processed' ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(record['status'], style: TextStyle(
                color: record['status'] == 'Processed' ? Colors.green : Colors.orange,
                fontFamily: 'Cairo'
              )),
            ),
            if (record['status'] != 'Processed')
              IconButton(
                icon: Icon(Icons.play_arrow, color: Colors.green),
                onPressed: () => _processPayroll(index),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.work, color: AppColors.primaryColor),
        title: Text(job['title'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job['department'], style: TextStyle(fontFamily: 'Cairo')),
            Text('${job['location']} • ${job['type']} • ${job['applicants']} applicants', 
              style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () => _applyForJob(job),
          child: Text('Apply', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ),
    );
  }

  Widget _buildTrainingCard(Map<String, dynamic> course) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.school, color: AppColors.primaryColor),
        title: Text(course['title'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Duration: ${course['duration']} • Level: ${course['level']}', style: TextStyle(fontFamily: 'Cairo')),
            Text('Instructor: ${course['instructor']} • ${course['enrolled']}/${course['capacity']} enrolled', 
              style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () => _enrollInTraining(course),
          child: Text('Enroll', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ),
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

  Widget _buildRecentPerformanceReviews() {
    final recentReviews = _performanceReviews.take(3).toList();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Performance Reviews', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                if (recentReviews.isNotEmpty)
                  Chip(
                    label: Text('Avg: ${(_performanceReviews.map((r) => r['rating']).reduce((a, b) => a + b) / _performanceReviews.length).toStringAsFixed(1)}',
                      style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
                    backgroundColor: Colors.teal,
                  ),
              ],
            ),
            SizedBox(height: 12),
            ...recentReviews.map((review) => _buildPerformanceReviewItem(review)),
            if (recentReviews.isEmpty)
              Text('No performance reviews yet', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceReviewItem(Map<String, dynamic> review) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      color: Colors.grey[50],
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRatingColor(review['rating']),
          child: Text(review['rating'].toStringAsFixed(1), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(review['employee'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review['period'], style: TextStyle(fontFamily: 'Cairo')),
            if (review['comments'] != null && review['comments'].isNotEmpty)
              Text(review['comments'], 
                   style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.grey),
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis),
          ],
        ),
        trailing: Icon(Icons.star, color: Colors.amber),
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
            // Add filter options here
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
              TextFormField(
                controller: _positionController,
                decoration: InputDecoration(labelText: 'Position'),
                validator: (value) => value!.isEmpty ? 'Please enter position' : null,
              ),
              TextFormField(
                controller: _departmentController,
                decoration: InputDecoration(labelText: 'Department'),
                validator: (value) => value!.isEmpty ? 'Please enter department' : null,
              ),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter salary' : null,
              ),
              DropdownButtonFormField(
                value: _selectedStatus,
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
              widget.onEmployeeAdded({
                'id': widget.employee?['id'] ?? '00${DateTime.now().millisecondsSinceEpoch}',
                'name': _nameController.text,
                'position': _positionController.text,
                'department': _departmentController.text,
                'salary': int.parse(_salaryController.text),
                'status': _selectedStatus,
                'joinDate': widget.employee?['joinDate'] ?? _formatDate(DateTime.now()),
              });
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
            onPressed: () {},
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
          TextFormField(
            controller: _allowancesController,
            decoration: InputDecoration(labelText: 'Allowances'),
            keyboardType: TextInputType.number,
            onChanged: _calculateNetSalary,
          ),
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
            widget.onPayrollCalculated({
              'period': '${DateTime.now().month}/${DateTime.now().year}',
              'basicSalary': double.parse(_basicSalaryController.text),
              'allowances': double.parse(_allowancesController.text),
              'deductions': double.parse(_deductionsController.text),
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Request Leave', style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold)),
          Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  value: _selectedType,
                  items: ['Annual Leave', 'Sick Leave', 'Emergency Leave', 'Maternity Leave']
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedType = value!),
                  decoration: InputDecoration(labelText: 'Leave Type'),
                ),
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
                TextFormField(
                  controller: _reasonController,
                  decoration: InputDecoration(labelText: 'Reason'),
                  maxLines: 3,
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

// Additional Pages
class RecruitmentPipelinePage extends StatefulWidget {
  final List<Map<String, dynamic>> pipeline;
  final Function(List<Map<String, dynamic>>) onCandidateUpdated;

  const RecruitmentPipelinePage({super.key, required this.pipeline, required this.onCandidateUpdated});

  @override
  State<RecruitmentPipelinePage> createState() => _RecruitmentPipelinePageState();
}

class _RecruitmentPipelinePageState extends State<RecruitmentPipelinePage> {
  late List<Map<String, dynamic>> _pipeline;

  @override
  void initState() {
    super.initState();
    _pipeline = List.from(widget.pipeline);
  }

  void _updateCandidateStage(int index, String newStage) {
    setState(() {
      _pipeline[index]['stage'] = newStage;
    });
    widget.onCandidateUpdated(_pipeline);
  }

  void _updateCandidateScore(int index, int score) {
    setState(() {
      _pipeline[index]['score'] = score;
    });
    widget.onCandidateUpdated(_pipeline);
  }

  void _showScoreDialog(int index) {
    final candidate = _pipeline[index];
    final currentScore = candidate['score'] ?? 0;
    TextEditingController scoreController = TextEditingController(text: currentScore.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Score for ${candidate['name']}', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current Score: ${candidate['score'] ?? 0}/100', style: TextStyle(fontFamily: 'Cairo')),
            SizedBox(height: 16),
            TextFormField(
              controller: scoreController,
              decoration: InputDecoration(
                labelText: 'Score (0-100)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                final score = int.tryParse(value ?? '');
                if (score == null || score < 0 || score > 100) {
                  return 'Please enter a valid score between 0-100';
                }
                return null;
              },
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
              final newScore = int.tryParse(scoreController.text) ?? 0;
              if (newScore >= 0 && newScore <= 100) {
                _updateCandidateScore(index, newScore);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Score updated to $newScore', style: TextStyle(fontFamily: 'Cairo'))),
                );
              }
            },
            child: Text('Update Score', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recruitment Pipeline', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Applied (${_pipeline.where((c) => c['stage'] == 'Applied').length})'),
                Tab(text: 'Screening (${_pipeline.where((c) => c['stage'] == 'Screening').length})'),
                Tab(text: 'Interview (${_pipeline.where((c) => c['stage'] == 'Interview').length})'),
                Tab(text: 'Offer (${_pipeline.where((c) => c['stage'] == 'Offer').length})'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPipelineList('Applied'),
                  _buildPipelineList('Screening'),
                  _buildPipelineList('Interview'),
                  _buildPipelineList('Offer'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineList(String stage) {
    final candidates = _pipeline.where((c) => c['stage'] == stage).toList();
    
    return ListView.builder(
      itemCount: candidates.length,
      itemBuilder: (context, index) {
        final candidate = candidates[index];
        final globalIndex = _pipeline.indexWhere((c) => c['id'] == candidate['id']);
        
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Text(candidate['name'][0], style: TextStyle(color: AppColors.primaryColor)),
            ),
            title: Text(candidate['name'], style: TextStyle(fontFamily: 'Cairo')),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(candidate['position'], style: TextStyle(fontFamily: 'Cairo')),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                    SizedBox(width: 4),
                    Text('Applied: ${candidate['appliedDate']}', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                  ],
                ),
                if (candidate['score'] != null && candidate['score'] > 0)
                  Row(
                    children: [
                      Icon(Icons.score, size: 12, color: Colors.orange),
                      SizedBox(width: 4),
                      Text('Score: ${candidate['score']}/100', 
                           style: TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
              ],
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => _buildStageMenuItems(globalIndex, candidate['stage']),
            ),
            onTap: () => _showCandidateDetails(globalIndex),
          ),
        );
      },
    );
  }

  void _showCandidateDetails(int index) {
    final candidate = _pipeline[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Candidate Details', style: TextStyle(fontFamily: 'Cairo')),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Name', candidate['name']),
              _buildDetailRow('Position', candidate['position']),
              _buildDetailRow('Stage', candidate['stage']),
              _buildDetailRow('Applied Date', candidate['appliedDate']),
              _buildDetailRow('Score', '${candidate['score'] ?? 0}/100'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showScoreDialog(index),
                child: Text('Update Score', style: TextStyle(fontFamily: 'Cairo')),
              ),
            ],
          ),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: TextStyle(fontFamily: 'Cairo'))),
        ],
      ),
    );
  }

  List<PopupMenuEntry> _buildStageMenuItems(int index, String currentStage) {
    final stages = ['Applied', 'Screening', 'Interview', 'Offer', 'Hired', 'Rejected'];
    
    return [
      PopupMenuItem(
        child: ListTile(
          leading: Icon(Icons.score, color: Colors.orange),
          title: Text('Update Score', style: TextStyle(fontFamily: 'Cairo')),
          onTap: () {
            Navigator.pop(context);
            _showScoreDialog(index);
          },
        ),
      ),
      PopupMenuDivider(),
      ...stages.map((stage) => PopupMenuItem(
        child: ListTile(
          leading: Icon(
            stage == currentStage ? Icons.radio_button_checked : Icons.radio_button_off,
            color: stage == currentStage ? AppColors.primaryColor : Colors.grey,
          ),
          title: Text(stage, style: TextStyle(
            fontFamily: 'Cairo',
            color: stage == currentStage ? AppColors.primaryColor : Colors.black,
            fontWeight: stage == currentStage ? FontWeight.bold : FontWeight.normal,
          )),
          onTap: () {
            Navigator.pop(context);
            _updateCandidateStage(index, stage);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Moved ${_pipeline[index]['name']} to $stage', style: TextStyle(fontFamily: 'Cairo'))),
            );
          },
        ),
      )).toList(),
    ];
  }
}

class TrainingManagementPage extends StatelessWidget {
  final List<Map<String, dynamic>> courses;
  final Function(List<Map<String, dynamic>>) onCourseUpdated;

  const TrainingManagementPage({super.key, required this.courses, required this.onCourseUpdated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Training Management', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ...courses.map((course) => _buildTrainingItem(course)),
        ],
      ),
    );
  }

  Widget _buildTrainingItem(Map<String, dynamic> course) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.school, color: AppColors.primaryColor),
        title: Text(course['title'], style: TextStyle(fontFamily: 'Cairo')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${course['duration']} • ${course['level']}', style: TextStyle(fontFamily: 'Cairo')),
            Text('Instructor: ${course['instructor']}', style: TextStyle(fontFamily: 'Cairo')),
            LinearProgressIndicator(
              value: course['enrolled'] / course['capacity'],
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                course['enrolled'] >= course['capacity'] ? Colors.red : Colors.green
              ),
            ),
            Text('${course['enrolled']}/${course['capacity']} enrolled', 
              style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
          ],
        ),
        trailing: Chip(
          label: Text(course['status'], style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          backgroundColor: course['status'] == 'Active' ? Colors.green : 
                         course['status'] == 'Full' ? Colors.red : Colors.orange,
        ),
      ),
    );
  }
}

class PerformanceReviewDialog extends StatefulWidget {
  final List<Map<String, dynamic>> employees;
  final Function(Map<String, dynamic>) onReviewSubmitted;

  const PerformanceReviewDialog({super.key, required this.employees, required this.onReviewSubmitted});

  @override
  State<PerformanceReviewDialog> createState() => _PerformanceReviewDialogState();
}

class _PerformanceReviewDialogState extends State<PerformanceReviewDialog> {
  String? _selectedEmployee;
  double _rating = 3.0;
  final _commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Performance Review', style: TextStyle(fontFamily: 'Cairo')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField(
            value: _selectedEmployee,
            items: widget.employees
                .map((employee) => DropdownMenuItem(
                      value: employee['id'],
                      child: Text(employee['name'], style: TextStyle(fontFamily: 'Cairo')),
                    ))
                .toList(),
            onChanged: (value) => setState(() => _selectedEmployee = value as String?),
            decoration: InputDecoration(labelText: 'Employee'),
          ),
          SizedBox(height: 16),
          Text('Rating: ${_rating.toStringAsFixed(1)}', style: TextStyle(fontFamily: 'Cairo')),
          Slider(
            value: _rating,
            min: 1,
            max: 5,
            divisions: 8,
            onChanged: (value) => setState(() => _rating = value),
          ),
          SizedBox(height: 16),
          Text('Comments:', style: TextStyle(fontFamily: 'Cairo')),
          TextField(
            controller: _commentsController,
            maxLines: 3,
            decoration: InputDecoration(hintText: 'Enter comments...'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontFamily: 'Cairo')),
        ),
        ElevatedButton(
          onPressed: _selectedEmployee == null ? null : () {
            final employee = widget.employees.firstWhere((e) => e['id'] == _selectedEmployee);
            widget.onReviewSubmitted({
              'employee': employee['name'],
              'period': 'Q1 ${DateTime.now().year}',
              'rating': _rating,
              'comments': _commentsController.text,
              'reviewer': 'Manager',
              'date': DateTime.now().toString(),
            });
            Navigator.pop(context);
          },
          child: Text('Submit Review', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}

class JobApplicationDialog extends StatefulWidget {
  final Map<String, dynamic> job;
  final Function(Map<String, dynamic>) onApplicationSubmitted;

  const JobApplicationDialog({super.key, required this.job, required this.onApplicationSubmitted});

  @override
  State<JobApplicationDialog> createState() => _JobApplicationDialogState();
}

class _JobApplicationDialogState extends State<JobApplicationDialog> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _experienceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Apply for ${widget.job['title']}', style: TextStyle(fontFamily: 'Cairo')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Full Name'),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Phone'),
            keyboardType: TextInputType.phone,
          ),
          TextFormField(
            controller: _experienceController,
            decoration: InputDecoration(labelText: 'Years of Experience'),
            keyboardType: TextInputType.number,
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
            widget.onApplicationSubmitted({
              'name': _nameController.text,
              'email': _emailController.text,
              'phone': _phoneController.text,
              'experience': _experienceController.text,
              'position': widget.job['title'],
              'appliedDate': DateTime.now().toString(),
            });
            Navigator.pop(context);
          },
          child: Text('Submit Application', style: TextStyle(fontFamily: 'Cairo')),
        ),
      ],
    );
  }
}