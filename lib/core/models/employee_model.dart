import 'dart:convert';

class EmployeeStats {
  final int allEmployees;
  final int attendanceToday;
  final int onLeave;
  final int absentToday;
  final List<EmployeeModel>? employees; // إضافة قائمة الموظفين

  EmployeeStats({
    required this.allEmployees,
    required this.attendanceToday,
    required this.onLeave,
    required this.absentToday,
    this.employees,
  });

  EmployeeStats.empty()
      : allEmployees = 0,
        attendanceToday = 0,
        onLeave = 0,
        absentToday = 0,
        employees = null;

  factory EmployeeStats.fromApiResponse(dynamic response) {
  print('🔍 Parsing EmployeeStats from response...');
  
  if (response == null) {
    print('⚠️ Response is null');
    return EmployeeStats.empty();
  }

  // إذا كانت الاستجابة نصاً
  if (response is String) {
    try {
      response = jsonDecode(response);
    } catch (e) {
      print('❌ Failed to decode JSON: $e');
      return EmployeeStats.empty();
    }
  }

  int allEmployees = 0;
  int attendanceToday = 0;
  int onLeave = 0;
  int absentToday = 0;

  // معالجة الاستجابة بناءً على الهيكل الجديد
  if (response is List) {
    print('📋 Response is a List with ${response.length} items');
    
    for (var item in response) {
      if (item is Map<String, dynamic>) {
        final typeName = item['typeName']?.toString() ?? '';
        final total = int.tryParse(item['totalEmployees']?.toString() ?? '0') ?? 0;
        
        print('📊 Found stat: $typeName = $total');
        
        switch (typeName) {
          case 'AllEmployees':
            allEmployees = total;
            break;
          case 'AttendanceToday':
            attendanceToday = total;
            break;
          case 'OnLeave':
            onLeave = total;
            break;
          case 'AbsentToday':
            absentToday = total;
            break;
        }
      }
    }
  } else if (response is Map<String, dynamic>) {
    print('🗺️ Response is a Map');
    
    // تحقق من وجود الحقول المباشرة
    if (response.containsKey('allEmployees') || 
        response.containsKey('attendanceToday')) {
      
      allEmployees = int.tryParse(response['allEmployees']?.toString() ?? '0') ?? 0;
      attendanceToday = int.tryParse(response['attendanceToday']?.toString() ?? '0') ?? 0;
      onLeave = int.tryParse(response['onLeave']?.toString() ?? '0') ?? 0;
      absentToday = int.tryParse(response['absentToday']?.toString() ?? '0') ?? 0;
      
      print('📊 Parsed stats from direct map fields');
    } else if (response.containsKey('data')) {
      // قد تكون البيانات في حقل 'data'
      final data = response['data'];
      if (data is List) {
        for (var item in data) {
          if (item is Map<String, dynamic>) {
            final typeName = item['typeName']?.toString() ?? '';
            final total = int.tryParse(item['totalEmployees']?.toString() ?? '0') ?? 0;
            
            switch (typeName) {
              case 'AllEmployees':
                allEmployees = total;
                break;
              case 'AttendanceToday':
                attendanceToday = total;
                break;
              case 'OnLeave':
                onLeave = total;
                break;
              case 'AbsentToday':
                absentToday = total;
                break;
            }
          }
        }
      }
    }
  }

  print('✅ Final stats - Total: $allEmployees, Present: $attendanceToday, Leave: $onLeave, Absent: $absentToday');
  
  return EmployeeStats(
    allEmployees: allEmployees,
    attendanceToday: attendanceToday,
    onLeave: onLeave,
    absentToday: absentToday,
    employees: null, // لن نقوم بتحميل الموظفين هنا
  );
}

  // دالة للتحقق من تناسق البيانات
  bool isConsistentWithEmployees(List<EmployeeModel> employees) {
    return allEmployees == employees.length;
  }
}

class EmployeeModel {
  final String id;
  final String name;
  final String position;
  final String department;
  final String status;
  final int salary;
  final String joinDate;
  final double basicSalary;
  final double homeValueAlW;
  final double travelValueAlW;
  final double allValueAlW;
  final double sumAlWValue;
  final double socialValueDeD;
  final double allValueDeD;
  final double sumDeDValue;
  final double sumAllValue;

  EmployeeModel({
    required this.id,
    String? name,
    String? position,
    String? department,
    String? status,
    int? salary,
    String? joinDate,
    double? basicSalary,
    double? homeValueAlW,
    double? travelValueAlW,
    double? allValueAlW,
    double? sumAlWValue,
    double? socialValueDeD,
    double? allValueDeD,
    double? sumDeDValue,
    double? sumAllValue,
  })  : name = name ?? '',
        position = position ?? '',
        department = department ?? '',
        status = status ?? 'Active',
        salary = salary ?? 0,
        joinDate = joinDate ?? '',
        basicSalary = basicSalary ?? 0.0,
        homeValueAlW = homeValueAlW ?? 0.0,
        travelValueAlW = travelValueAlW ?? 0.0,
        allValueAlW = allValueAlW ?? 0.0,
        sumAlWValue = sumAlWValue ?? 0.0,
        socialValueDeD = socialValueDeD ?? 0.0,
        allValueDeD = allValueDeD ?? 0.0,
        sumDeDValue = sumDeDValue ?? 0.0,
        sumAllValue = sumAllValue ?? 0.0;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    // محاولة استخراج الـ ID من حقول مختلفة
    String id = '';
    if (json['employeeId'] != null) {
      id = json['employeeId'].toString();
    } else if (json['id'] != null) {
      id = json['id'].toString();
    } else if (json['basicEmployeesId'] != null) {
      id = json['basicEmployeesId'].toString();
    } else if (json['EmployeeID'] != null) {
      id = json['EmployeeID'].toString();
    }
    
    // محاولة استخراج الاسم من حقول مختلفة
    String name = '';
    if (json['employeeName'] != null) {
      name = json['employeeName'].toString();
    } else if (json['name'] != null) {
      name = json['name'].toString();
    } else if (json['employeeNameFRN'] != null) {
      name = json['employeeNameFRN'].toString();
    } else if (json['EmployeeName'] != null) {
      name = json['EmployeeName'].toString();
    }
    
    // محاولة استخراج الراتب من حقول مختلفة
    double basicSalary = 0.0;
    if (json['basicSalary'] != null) {
      basicSalary = _parseDouble(json['basicSalary']);
    } else if (json['salary'] != null) {
      basicSalary = _parseDouble(json['salary']);
    } else if (json['Salary'] != null) {
      basicSalary = _parseDouble(json['Salary']);
    }

    return EmployeeModel(
      id: id,
      name: name,
      position: json['position']?.toString() ?? 
               json['Position']?.toString() ?? '',
      department: json['department']?.toString() ?? 
                  json['Department']?.toString() ?? '',
      status: json['status']?.toString() ?? 
              json['Status']?.toString() ?? 'Active',
      salary: _parseInt(json['salary'] ?? json['Salary'] ?? basicSalary),
      joinDate: json['joinDate']?.toString() ?? 
                json['JoinDate']?.toString() ?? '',
      basicSalary: basicSalary,
      homeValueAlW: _parseDouble(json['homeValueAlW'] ?? json['HomeValueAlW']),
      travelValueAlW: _parseDouble(json['travelValueAlW'] ?? json['TravelValueAlW']),
      allValueAlW: _parseDouble(json['allValueAlW'] ?? json['AllValueAlW']),
      sumAlWValue: _parseDouble(json['sumAlWValue'] ?? json['SumAlWValue']),
      socialValueDeD: _parseDouble(json['socialValueDeD'] ?? json['SocialValueDeD']),
      allValueDeD: _parseDouble(json['allValueDeD'] ?? json['AllValueDeD']),
      sumDeDValue: _parseDouble(json['sumDeDValue'] ?? json['SumDeDValue']),
      sumAllValue: _parseDouble(json['sumAllValue'] ?? json['SumAllValue']),
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      // إزالة أي رموز غير رقمية مثل $
      final cleaned = value.replaceAll(RegExp(r'[^\d.]'), '');
      return int.tryParse(cleaned) ?? 0;
    }
    return 0;
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      // إزالة أي رموز غير رقمية مثل $
      final cleaned = value.replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleaned) ?? 0.0;
    }
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'department': department,
      'status': status,
      'salary': salary,
      'joinDate': joinDate,
      'basicSalary': basicSalary,
      'homeValueAlW': homeValueAlW,
      'travelValueAlW': travelValueAlW,
      'allValueAlW': allValueAlW,
      'sumAlWValue': sumAlWValue,
      'socialValueDeD': socialValueDeD,
      'allValueDeD': allValueDeD,
      'sumDeDValue': sumDeDValue,
      'sumAllValue': sumAllValue,
    };
  }

  // دالة للتحقق إذا كان الموظف صالحاً
  bool isValid() {
    return id.isNotEmpty && name.isNotEmpty;
  }
}