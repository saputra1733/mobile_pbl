import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiLogin {
  static const String baseUrl = 'http://192.168.100.12:8000/api/v1/login'; 

  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse(baseUrl); 

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

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
          'message': response.statusCode == 422
              ? (jsonDecode(response.body)['errors'] as Map<String, dynamic>)
                  .values
                  .join(', ')
              : 'Server error: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: Tidak dapat terhubung ke server ($e)'};
    }
  }
}
