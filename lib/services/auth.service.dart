import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class AuthService {
  static const String _baseUrl = 'http://localhost:3000/api';

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try{
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if(response.statusCode == 201){
        var data = jsonDecode(response.body);
        return data;
      }else{
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }

    }catch(e){
      // ignore: avoid_print
      print('Error during login: $e');
      throw Exception('Failed to login: $e');
    }
  }

  static Future<Map<String, dynamic>> getUser(int id, String password ) async {
    try{
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/user'),
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(data['result']));
        return data;
      }else{
        throw Exception('Failed to get user. Status code: ${response.statusCode}');
      }

    }catch(e){
      // ignore: avoid_print
      print('Error during get user: $e');
      throw Exception('Failed to get user: $e');
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}