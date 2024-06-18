import 'dart:convert';
import 'package:http/http.dart' as http;
class GuardianService {
    static const String _baseUrl = 'https://backend-odoo-production.up.railway.app/api';

  static Future<Map<String, dynamic>> getStudents(int id , String password, int  guardianId) async {
      
      try {
        final response = await http.post(
          Uri.parse('$_baseUrl/guardian/get-student'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id': id,
            'password': password,
            'guardian_id': guardianId
          }),
        );
        if(response.statusCode == 201){
          var data = jsonDecode(response.body);
          return data;
        }else{
          throw Exception('Failed to get students. Status code: ${response.statusCode}');
        }
  
      } catch (e) {
        // ignore: avoid_print
        print('Error during get students: $e');
        throw Exception('Failed to get students: $e');
      }

  }

  static Future<Map<String, dynamic>> getPeriods(int id , String password, ) async {
      
      try {
        final response = await http.post(
          Uri.parse('$_baseUrl/guardian/get-period'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id': id,
            'password': password,
          }),
        );
        if(response.statusCode == 201){
          var data = jsonDecode(response.body);
          return data;
        }else{
          throw Exception('Failed to get students. Status code: ${response.statusCode}');
        }
  
      } catch (e) {
        // ignore: avoid_print
        print('Error during get students: $e');
        throw Exception('Failed to get students: $e');
      }

  }

  static Future<Map<String, dynamic>> marks(int id , String password, int periodId, int studentId) async {
      
      try {
        final response = await http.post(
          Uri.parse('$_baseUrl/guardian/get-marks'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id': id,
            'password': password,
            'period_id': periodId,
            'student_id': studentId
          }),
        );
        if(response.statusCode == 201){
          var data = jsonDecode(response.body);
          return data;
        }else{
          throw Exception('Failed to get grades. Status code: ${response.statusCode}');
        }
  
      } catch (e) {
        // ignore: avoid_print
        print('Error during get grades: $e');
        throw Exception('Failed to get grades: $e');
      }

  }

  static Future<Map<String, dynamic>> getAnnouncement(int id , String password) async {
      
      try {
        final response = await http.post(
          Uri.parse('$_baseUrl/guardian/get-announcement'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id': id,
            'password': password
          }),
        );
        if(response.statusCode == 201){
          var data = jsonDecode(response.body);
          return data;
        }else{
          throw Exception('Failed to get grades. Status code: ${response.statusCode}');
        }
  
      } catch (e) {
        // ignore: avoid_print
        print('Error during get grades: $e');
        throw Exception('Failed to get grades: $e');
      }

  }




}