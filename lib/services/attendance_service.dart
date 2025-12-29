// attendance_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AttendanceService {
  static const String baseUrl = 'https://fc.visioncit.com';

  // Register attendance in/out or break
  static Future<Map<String, dynamic>> recordAttendance({
    required int employeeId,
    required DateTime recordDateTime,
    required int dateType,
    String? token,
  }) async {
    try {
      // Format date as required by the API
      final formattedDateTime = '${recordDateTime.year}-${recordDateTime.month.toString().padLeft(2, '0')}-${recordDateTime.day.toString().padLeft(2, '0')} ${recordDateTime.hour.toString().padLeft(2, '0')}:${recordDateTime.minute.toString().padLeft(2, '0')}';
      
      final url = Uri.parse(
        '$baseUrl/api/EmployeeWork/RecordDateTime?'
        'employeeId=$employeeId&'
        'recordDateTime=${Uri.encodeComponent(formattedDateTime)}&'
        'dateType=$dateType',
      );

      print('📝 Recording attendance: $url');

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': 'en',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        url,
        headers: headers,
      ).timeout(Duration(seconds: 10));

      print('📡 Response status: ${response.statusCode}');
      print('📊 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': responseData['flag'] == true,
          'responseType': responseData['responseType'],
          'message': responseData['message'],
          'modelId': responseData['modelId'],
          'otherResult': responseData['otherResult'],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to record attendance. Status: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('❌ Error recording attendance: $e');
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Register absence
  static Future<Map<String, dynamic>> recordAbsence({
    required int employeeId,
    required DateTime absenceDate,
    required String reason,
    int? managerId,
    String? absenceAttached,
    String? token,
  }) async {
    try {
      final formattedDate = '${absenceDate.year}-${absenceDate.month.toString().padLeft(2, '0')}-${absenceDate.day.toString().padLeft(2, '0')}';
      
      String url = '$baseUrl/api/EmployeeWork/RecordAbsence?'
        'employeeId=$employeeId&'
        'absenceDate=${Uri.encodeComponent(formattedDate)}&'
        'reason=${Uri.encodeComponent(reason)}';
      
      // Add optional parameters
      if (managerId != null) {
        url += '&managerId=$managerId';
      }
      if (absenceAttached != null && absenceAttached.isNotEmpty) {
        url += '&absenceAttached=${Uri.encodeComponent(absenceAttached)}';
      }

      final uri = Uri.parse(url);
      print('📝 Recording absence: $uri');

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': 'en',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        uri,
        headers: headers,
      ).timeout(Duration(seconds: 10));

      print('📡 Response status: ${response.statusCode}');
      print('📊 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': responseData['flag'] == true,
          'responseType': responseData['responseType'],
          'message': responseData['message'],
          'modelId': responseData['modelId'],
          'otherResult': responseData['otherResult'],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to record absence. Status: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('❌ Error recording absence: $e');
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Register accepted absence
  static Future<Map<String, dynamic>> recordAcceptedAbsence({
    required int employeeId,
    required int managerId,
    required int absenceId,
    String? token,
  }) async {
    try {
      final url = Uri.parse(
        '$baseUrl/api/EmployeeWork/RecordAcceptedAbsence?'
        'employeeId=$employeeId&'
        'managerId=$managerId&'
        'absenced=$absenceId',
      );

      print('📝 Recording accepted absence: $url');

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': 'en',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        url,
        headers: headers,
      ).timeout(Duration(seconds: 10));

      print('📡 Response status: ${response.statusCode}');
      print('📊 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': responseData['flag'] == true,
          'responseType': responseData['responseType'],
          'message': responseData['message'],
          'modelId': responseData['modelId'],
          'otherResult': responseData['otherResult'],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to record accepted absence. Status: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('❌ Error recording accepted absence: $e');
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  // Get attendance history for an employee
  static Future<List<Map<String, dynamic>>> getAttendanceHistory({
    required int employeeId,
    DateTime? fromDate,
    DateTime? toDate,
    String? token,
  }) async {
    try {
      String url = '$baseUrl/api/EmployeeWork/GetAttendanceHistory?employeeId=$employeeId';
      
      if (fromDate != null) {
        final formattedFrom = '${fromDate.year}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}';
        url += '&fromDate=${Uri.encodeComponent(formattedFrom)}';
      }
      
      if (toDate != null) {
        final formattedTo = '${toDate.year}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}';
        url += '&toDate=${Uri.encodeComponent(formattedTo)}';
      }

      final uri = Uri.parse(url);
      print('📊 Fetching attendance history: $uri');

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': 'en',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        uri,
        headers: headers,
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        // Check API response structure
        if (responseData['flag'] == true) {
          // Process the attendance data
          List<dynamic> dataList = [];
          if (responseData['data'] is List) {
            dataList = responseData['data'];
          } else if (responseData is List) {
            dataList = responseData;
          }
          
          return dataList.map((item) {
            return {
              'date': item['date'] ?? '',
              'firstStartTime': item['firstStartTime'] ?? '--',
              'firstEndTime': item['firstEndTime'] ?? '--',
              'secondStartTime': item['secondStartTime'] ?? '--',
              'secondEndTime': item['secondEndTime'] ?? '--',
              'breakStartTime': item['breakStartTime'] ?? '--',
              'breakEndTime': item['breakEndTime'] ?? '--',
              'totalHours': item['totalHours'] ?? 0,
              'status': item['status'] ?? 'Absent',
              'breaks': item['breaks'] ?? [],
            };
          }).toList();
        } else {
          print('❌ API returned error: ${responseData['message']}');
          return [];
        }
      } else {
        print('❌ Failed to fetch attendance history. Status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('❌ Error fetching attendance history: $e');
      return [];
    }
  }

  // Get today's attendance status for an employee
  static Future<Map<String, dynamic>> getTodayAttendance(int employeeId, {String? token}) async {
    try {
      final today = DateTime.now();
      final attendanceHistory = await getAttendanceHistory(
        employeeId: employeeId,
        fromDate: DateTime(today.year, today.month, today.day),
        toDate: DateTime(today.year, today.month, today.day),
        token: token,
      );

      if (attendanceHistory.isNotEmpty) {
        return attendanceHistory.first;
      } else {
        return {
          'date': '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}',
          'firstStartTime': '--',
          'firstEndTime': '--',
          'secondStartTime': '--',
          'secondEndTime': '--',
          'breakStartTime': '--',
          'breakEndTime': '--',
          'totalHours': 0,
          'status': 'Absent',
          'breaks': [],
        };
      }
    } catch (e) {
      print('❌ Error getting today\'s attendance: $e');
      return {
        'date': '',
        'firstStartTime': '--',
        'firstEndTime': '--',
        'secondStartTime': '--',
        'secondEndTime': '--',
        'breakStartTime': '--',
        'breakEndTime': '--',
        'totalHours': 0,
        'status': 'Absent',
        'breaks': [],
      };
    }
  }

  // DateType constants (from PDF)
  static const int firstStartDateTime = 1;
  static const int firstEndDateTime = 2;
  static const int secondStartDateTime = 3;
  static const int secondEndDateTime = 4;
  static const int startBreakDateTime = 5;
  static const int endBreakDateTime = 6;
}
