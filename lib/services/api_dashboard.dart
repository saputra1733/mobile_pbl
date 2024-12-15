import 'dart:convert';
import 'package:mobile_pbl/services/api_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiDashboard {
  Future<String> getBaseUrl() async {
    // fetch profile
    final profile = await ApiProfile().fetchProfile();
    final role = profile['data']['level_nama'];
    
    return role.toLowerCase() == 'dosen' 
      ? 'http://192.168.100.12:8000/api/v1/dosen/dashboard' 
      : 'http://192.168.100.12:8000/api/v1/kaprodi/dashboard';
  }

  Future<Map<String, dynamic>> fetchDashboardData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final baseUrl = await getBaseUrl();
      print('Request ke: $baseUrl');
      print('Token yang dikirim: $token');

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load dashboard data');
      }
    } catch (e) {
      throw Exception('Error fetching dashboard data: $e');
    }
  }
}