import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';



class RegisterAttendanceService {
  static const String _baseUrl = 'https://backend-odoo-production.up.railway.app/api';

  static Future<Map<String, dynamic>> createRegisterAttendance(
      int id, String password, int gradeID) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register-attendance/create-attendance'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'password': password,
          'grade_id': gradeID,
        }),
      );
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
            'Failed to create register attendance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error during create register attendance: $e');
      throw Exception('Failed to create register attendance: $e');
    }
  }




//////////////////////////////////
  static Future<Map<String, dynamic>> getRegisterAttendance(
      int id, String password, int gradeId) async {
    try {

      final response = await http.post(
        Uri.parse('$_baseUrl/register-attendance/get-register-attendance'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'password': password,
          'grade_id': gradeId,
        }),
      );
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
            'Failed to get register attendance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error during get register attendance: $e');
      throw Exception('Failed to get register attendance: $e');
    }
  }

  static Future<Map<String, dynamic>> getAttendance(
      int id, String password, int registerAttendanceId) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register-attendance/get-attendance-student'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'password': password,
          'register_attendance_id': registerAttendanceId,
        }),
      );
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
            'Failed to update attendance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error during update attendance: $e');
      throw Exception('Failed to update attendance: $e');
    }
  }


  //////////////////////////


  static Future<Map<String, dynamic>> updateAttendanceStudent(int id, String password, int attendanceId, bool attended, bool leave, bool missing) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register-attendance/get-attendance-student'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'password': password,
          'attendance_id': attendanceId,
          'attended': attended,
          'leave': leave,
          'missing': missing,
        }),
      );
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
            'Failed to update attendance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error during update attendance: $e');
      throw Exception('Failed to update attendance: $e');
    }
  }

  static Future<Map<String, dynamic>> generateAttendanceIA(int id, String password, int registerAttendanceId, File photo) async {
    try {
      final dio = Dio();
      final formData = FormData.fromMap({
        'id': id,
        'password': password,
        'register_attendance_id': registerAttendanceId,
        'file': await MultipartFile.fromFile(photo.path, filename: photo.path.split('/').last),
      });  
      final response = await dio.post(
        '$_baseUrl/register-attendance/image-upload',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      ); 
      if (response.statusCode == 201) {
        var data = response.data;
        return data;
      } else {
        throw Exception(
            'Failed to generate attendance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error during get attendance: $e');
      throw Exception('Failed to get attendance: $e');
    }
  }
}
