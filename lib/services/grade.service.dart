import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class GradeService {
    static const String _baseUrl = 'https://backend-odoo-production.up.railway.app/api';

  static Future<Map<String, dynamic>> getGrades(int id , String password, int teacherId) async {

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register-attendance/get-grades'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'password': password,
          'teacher_id': teacherId
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