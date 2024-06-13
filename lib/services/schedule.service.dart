import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class ScheduleService {
  static const String _baseUrl = 'http://192.168.0.10:3000/api';

  static Future<Map<String, dynamic>> getSchedules(int id, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/employee/shedules'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'password': password,
        }),
      );
        var data = jsonDecode(response.body);
        return data;
     
    } catch (e) {
      // ignore: avoid_print
      print('Error during get schedules: $e');
      throw Exception('Failed to get schedules: $e');
    }
    
  }
}
