import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiProfile {
  static const String baseUrl = 'http://192.168.100.12:8000/api/v1/profile';

  Future<Map<String, dynamic>> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan. Silakan login kembali.'};
    }
    print('Token yang dikirim: $token');
    print('Request ke: $baseUrl');

    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data['user']};
      } else {
        return {'success': false, 'message': 'Server error: ${response.statusCode}'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> profileData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Convert profileData to Map<String, String>
    Map<String, String> stringProfileData = profileData.map((key, value) => MapEntry(key, value.toString()));

    if (token == null) {
      return {'success': false, 'message': 'Token tidak ditemukan. Silakan login kembali.'};
    }
    print('Token yang dikirim: $token');
    print('Request ke: $baseUrl');
    stringProfileData.remove('foto');
    print('Data yang dikirim: $stringProfileData');

    try {
      final request = http.MultipartRequest('POST', Uri.parse(baseUrl+'/update'))
        ..headers['Authorization'] = 'Bearer $token'
        ..fields.addAll(stringProfileData);

      final response = await request.send();

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Profile updated successfully.'};
      } else {
        final responseBody = await response.stream.bytesToString();
        final responseData = json.decode(responseBody);
        return {
          'success': false,
          'message': responseData['message'],
          'errors': responseData['errors']
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
