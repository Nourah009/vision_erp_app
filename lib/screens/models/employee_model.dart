class EmployeeStats {
  final int allEmployees;
  final int attendanceToday;
  final int onLeave;
  final int absentToday;

  EmployeeStats({
    required this.allEmployees,
    required this.attendanceToday,
    required this.onLeave,
    required this.absentToday,
  });

  // إضافة constructor فارغ للقيم الافتراضية
  EmployeeStats.empty()
      : allEmployees = 0,
        attendanceToday = 0,
        onLeave = 0,
        absentToday = 0;

  factory EmployeeStats.fromApiResponse(List<dynamic> response) {
    int allEmployees = 0;
    int attendanceToday = 0;
    int onLeave = 0;
    int absentToday = 0;

    for (var item in response) {
      final typeName = item['typeName'] as String;
      final total = int.tryParse(item['totalEmployees'].toString()) ?? 0;
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

    return EmployeeStats(
      allEmployees: allEmployees,
      attendanceToday: attendanceToday,
      onLeave: onLeave,
      absentToday: absentToday,
    );
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

  EmployeeModel({
    required this.id,
    required this.name,
    required this.position,
    required this.department,
    required this.status,
    required this.salary,
    required this.joinDate,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      position: json['position']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      salary: json['salary'] is int ? json['salary'] : int.tryParse(json['salary']?.toString() ?? '0') ?? 0,
      joinDate: json['joinDate']?.toString() ?? '',
    );
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
    };
  }
}
