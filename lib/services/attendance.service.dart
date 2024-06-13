import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class AttendanceService {
  static const String _baseUrl = 'https://backend-odoo-production.up.railway.app/api';

  static Future<Map<String, dynamic>> getAttendance(int id , String password, int registerAttendanceId) async  {
    try{
      final response = await http.post(
        Uri.parse('$_baseUrl/attendance/attendances'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'password': password,
          'register_attendance_id': registerAttendanceId,
        }),
      );
      if(response.statusCode == 201){
        var data = jsonDecode(response.body);
        return data;
      }else{
        throw Exception('Failed to get attendance. Status code: ${response.statusCode}');
      }

    }catch(e){
      // ignore: avoid_print
      print('Error during get attendance: $e');
      throw Exception('Failed to get attendance: $e');
    }


  }
}
