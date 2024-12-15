import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProgressService {
  static const String baseUrl =
      'http://192.168.100.12:8000/api/v1/dosen/dokumentasi';

  Future<Map<String, dynamic>> getKegiatanList() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Silakan login kembali.'
      };
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/agenda'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          return {
            'success': true,
            'message': data['message'],
            'data': data['data']
          };
        } else {
          return {'success': false, 'message': data['message']};
        }
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> updateProgress(
      int agendaId, int progress, http.MultipartFile? file) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Silakan login kembali.'
      };
    }

    try {
      // Create a MultipartRequest
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/update/$agendaId'), // Endpoint URL
      );

      // Add Authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields (if any)
      request.fields['progres'] = progress.toString();
      request.fields['deskripsi_dokumentasi'] =
          'Some description here'; // Example text field

      // Add the file
      if (file != null) {
        request.files.add(file);
      }

      // debug request
      print('Request: ${request.method} ${request.url}');
      print('Headers: ${request.headers}');
      print('Fields: ${request.fields}');
      // Send the request
      var response = await request.send();

      // Check response status
      if (response.statusCode == 200) {
        // If successful, decode the response body
        var responseData = await response.stream.bytesToString();
        Map<String, dynamic> data = json.decode(responseData);
        return {'success': true, 'message': data['message']};
      } else {
        var responseData = await response.stream.bytesToString();
        Map<String, dynamic> data = json.decode(responseData);
        if (data['status'] == 'error') {
          return {'success': false, 'message': data['message']};
        }

        // Handle non-200 status codes
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (e) {
      // Handle errors
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
