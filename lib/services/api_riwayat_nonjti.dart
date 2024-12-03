import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://your-backend-url.com/api"; // Ganti dengan URL backend Anda

  Future<List<dynamic>> getProgress() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/progress'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN', // Ganti dengan token jika menggunakan autentikasi
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load progress');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProgress(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/progress'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN',
        },
        body: json.encode(data),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add progress');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProgress(int id, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/progress/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN',
        },
        body: json.encode(data),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update progress');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProgress(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/progress/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete progress');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> searchKegiatan(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/kegiatan?search=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to search kegiatan');
      }
    } catch (e) {
      rethrow;
    }
  }
}
