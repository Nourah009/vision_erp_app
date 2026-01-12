import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vision_erp_app/core/models/employee_model.dart';
class HRService {
  static const String baseUrl = 'https://fc.visioncit.com';
  
  // 1. API للداشبورد (الإحصائيات)
  static Future<EmployeeStats> getEmployeeCounts(int organizationId) async {
  try {
    final url = Uri.parse(
      '$baseUrl/api/HR/Employee/GetEmployeeCounts?orgId=$organizationId',
    );
    
    print('🌐 Fetching employee counts from: $url');
    
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      // إضافة timeout لمنع التجميد
    ).timeout(Duration(seconds: 10));

    print('📡 Response status: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      print('📊 Raw API Response: ${response.body}');
      
      try {
        final responseData = jsonDecode(response.body);
        
        // طباعة بنية البيانات للمساعدة في التصحيح
        print('🔍 Response data type: ${responseData.runtimeType}');
        if (responseData is List) {
          print('📋 Response is a list with ${responseData.length} items');
          for (var i = 0; i < responseData.length; i++) {
            if (responseData[i] is Map) {
              print('  Item $i: ${responseData[i]}');
            }
          }
        } else if (responseData is Map) {
          print('🗺️ Response is a map with keys: ${responseData.keys}');
        }
        
        return EmployeeStats.fromApiResponse(responseData);
      } catch (e) {
        print('❌ JSON parsing error: $e');
        return EmployeeStats.empty();
      }
    } else {
      print('❌ API failed with status: ${response.statusCode}');
      print('📝 Response body: ${response.body}');
      return EmployeeStats.empty();
    }
  } catch (e) {
    print('❌ Network error fetching employee counts: $e');
    return EmployeeStats.empty();
  }
}
  // 2. API للموظفين (البيانات الأساسية)
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
        print('👥 Employees API Response: ${response.body}');
        final responseData = jsonDecode(response.body);
        
        // تحقق من بنية الاستجابة
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('messageCode') && responseData['messageCode'] != 9) {
            print('❌ Employees API Error: ${responseData['messageText']}');
            return [];
          }
        }
        
        List<dynamic> dataList = [];
        if (responseData is List) {
          dataList = responseData;
        } else if (responseData is Map) {
          // البحث عن الحقل الذي يحتوي على القائمة
          for (var value in responseData.values) {
            if (value is List) {
              dataList = value;
              break;
            }
          }
        }
        
        if (dataList.isEmpty) {
          print('⚠️ No employees found in API response');
          return [];
        }
        
        final employees = dataList
            .map((item) => EmployeeModel.fromJson(item))
            .toList();
        
        print('✅ Loaded ${employees.length} employees');
        return employees;
      } else {
        print('❌ Employees API failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('❌ Error fetching employees: $e');
      return [];
    }
  }

  // 3. API للرواتب (البيانات المالية)
  static Future<List<EmployeeModel>> getEmployeeFinancialByOrgId(int organizationId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/HR/Employee/GetEmployeeFinancialByOrgId?orgId=$organizationId',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('💰 Financial API Response: ${response.body}');
        final responseData = jsonDecode(response.body);
        
        // تحقق من بنية الاستجابة
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('messageCode') && responseData['messageCode'] != 9) {
            print('❌ Financial API Error: ${responseData['messageText']}');
            return [];
          }
        }
        
        List<dynamic> dataList = [];
        if (responseData is List) {
          dataList = responseData;
        } else if (responseData is Map) {
          for (var value in responseData.values) {
            if (value is List) {
              dataList = value;
              break;
            }
          }
        }
        
        return dataList
            .map((item) => EmployeeModel.fromJson(item))
            .toList();
      } else {
        print('❌ Financial API failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('❌ Error fetching financial data: $e');
      return [];
    }
  }

  // 4. دالة متكاملة لجلب جميع البيانات مع التأكد من الترابط
  static Future<Map<String, dynamic>> getAllEmployeeData(int organizationId) async {
    try {
      print('🔄 Fetching all employee data for organization: $organizationId');
      
      // جلب الإحصائيات
      final stats = await getEmployeeCounts(organizationId);
      print('📊 Stats loaded: ${stats.allEmployees} total employees');
      
      // جلب الموظفين
      final employees = await getEmployeesByOrgId(organizationId);
      print('👥 Employees loaded: ${employees.length} employees');
      
      // جلب البيانات المالية
      final financialEmployees = await getEmployeeFinancialByOrgId(organizationId);
      print('💰 Financial data loaded for ${financialEmployees.length} employees');
      
      // التأكد من أن عدد الموظفين في الإحصائيات يتطابق مع الموظفين الفعليين
      if (stats.allEmployees > 0 && employees.length != stats.allEmployees) {
        print('⚠️ Warning: Stats count (${stats.allEmployees}) != Actual employees (${employees.length})');
      }
      
      return {
        'stats': stats,
        'employees': employees,
        'financialData': financialEmployees,
      };
    } catch (e) {
      print('❌ Error in getAllEmployeeData: $e');
      return {
        'stats': EmployeeStats.empty(),
        'employees': [],
        'financialData': [],
      };
    }
  }
}