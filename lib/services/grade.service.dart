import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class GradeService {
    static const String _baseUrl = 'http://192.168.0.10:3000/api';

  static Future<Map<String, dynamic>> getGrades(int id , String password) async {

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/employee/grades'),
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
        throw Exception('Failed to get grades. Status code: ${response.statusCode}');
      }

    } catch (e) {
      // ignore: avoid_print
      print('Error during get grades: $e');
      throw Exception('Failed to get grades: $e');
    }
  }


  
 

}