import 'dart:convert';
import 'package:http/http.dart' as http;

// نموذج لإحصائيات الموظفين
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

class HRService {
  static const String baseUrl = 'https://fc.visioncit.com';
  
  // جلب إحصائيات الموظفين بناءً على organizationId
  static Future<EmployeeStats> getEmployeeCounts(int organizationId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/HR/Employee/GetEmployeeCountsByOrgId?orgId=$organizationId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as List<dynamic>;
        return EmployeeStats.fromApiResponse(responseData);
      } else {
        throw Exception('Failed to load employee stats: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching employee stats: $e');
      rethrow;
    }
  }
  
  // جلب بيانات الموظفين
  static Future<List<Map<String, dynamic>>> getEmployees(int organizationId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/HR/Employee/GetAllEmployees?orgId=$organizationId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as List<dynamic>;
        // تحويل البيانات من API إلى قائمة
        return responseData.map((item) {
          return {
            'id': item['employeeId']?.toString() ?? '',
            'name': item['employeeName'] ?? '',
            'nameNative': item['nameNative'] ?? '',
            'nameForeign': item['nameForeign'] ?? '',
            'position': item['position'] ?? '',
            'department': item['department'] ?? '',
            'status': item['status'] ?? 'Active',
            'salary': double.tryParse(item['salary']?.toString() ?? '0') ?? 0.0,
            'joinDate': item['joinDate'] ?? '',
            'employeeCode': item['employeeCode'] ?? '',
          };
        }).toList();
      } else {
        throw Exception('Failed to load employees: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching employees: $e');
      return []; // إرجاع قائمة فارغة في حالة الخطأ
    }
  }
}