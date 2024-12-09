import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiLogin {
  static const String baseUrl = 'http://192.168.66.134:8000/api/v1/login'; 

  Future<Map<String, dynamic>> login(String username, String password, String levelId) async {
    final url = Uri.parse(baseUrl); 

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'level_id': levelId,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      // print('Request body: ${jsonEncode({
      //   'username': username,
      //   'password': password,
      //   'level_id': levelId,
      // })}');

      // Periksa respons server
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success']) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', data['token']);
          print('Token berhasil disimpan: ${data['token']}');
          
          return {
            'success': true,
            'token': data['token'],
            'user': data['user'],
          };
        } else {
          return {'success': false, 'message': data['message'] ?? 'Login gagal'};
        }
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: Tidak dapat terhubung ke server ($e)'};
    }
  }
}
