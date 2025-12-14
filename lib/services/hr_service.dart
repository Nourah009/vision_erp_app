import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vision_erp_app/screens/models/employee_model.dart';

class HRService {
  static const String baseUrl = 'https://fc.visioncit.com';

  // **التصحيح هنا**: يجب أن ترجع List<EmployeeModel> وليس List<EmployeeStats>
  static Future<List<EmployeeModel>> getEmployeesByOrgId(int organizationId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/HR/Employee/GetEmployeesByOrgId?orgId=$organizationId',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        // **التصحيح هنا**: استخدم EmployeeModel.fromJson وليس EmployeeStats.fromJson
        return responseData
            .map((item) => EmployeeModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load employees: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching employees: $e');
      return [];
    }
  }

  static Future<EmployeeStats> getEmployeeCounts(int organizationId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/HR/Employee/GetEmployeeCounts?orgId=$organizationId',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return EmployeeStats.fromApiResponse(responseData);
      } else {
        throw Exception('Failed to load employee counts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching employee counts: $e');
      rethrow;
    }
  }
}