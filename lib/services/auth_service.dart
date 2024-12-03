// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'api_client.dart';
// import 'dart:io';


// class AuthService {
//   final ApiClient _apiClient = ApiClient();
//   final Dio dio = Dio(BaseOptions(
//   baseUrl: 'http://192.168.100.12:8000/api/v1', // Sesuaikan dengan server Anda
//   connectTimeout: Duration(seconds: 10),
//   receiveTimeout: Duration(seconds: 10),
// ));


//   Future<bool> login(String levelId, String username, String password) async {
//   try {
//     print('Attempting login...');
//     print('Request Data: {username: $username, password: $password}');
    
//     final response = await _apiClient.dio.post('/login', data: {
//       'level_id': levelId,
//       'username': username,
//       'password': password,
//     });

//     print('Response Status Code: ${response.statusCode}');
//     print('Response Data: ${response.data}');

//     if (response.statusCode == 200 && response.data['success']) {
//        final token = response.data['token'];
//       if (token != null && token.isNotEmpty) {
//         print('Token from API: $token');
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', token);
//         print('Token saved to SharedPreferences: ${prefs.getString('token')}');
//         return true;
//       } else {
//         print('Token tidak valid atau kosong.');
//         return false;
//       }
//     } else {
//       print('Login failed: ${response.data}');
//       return false;
//     }
    
//   } on DioError catch (e) {
//     print('DioError: ${e.message}');
//     print('Response: ${e.response?.data}');
//     print('Error Details: ${e.error}');
//     return false;
//   } catch (e) {
//     print('Unexpected Error: $e');
//     return false;
//   }
// }


//   Future<void> logout() async {
//   try {
//     final token = await getToken();
//     if (token != null) {
//       await dio.post(
//         '/logout',
//         options: Options(
//           headers: {'Authorization': 'Bearer $token'},
//         ),
//       );
//     }
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token');
//     print('Berhasil logout.');
//   } catch (e) {
//     print('Gagal logout: $e');
//   }
// }

//   isLoggedIn() {}

//   Future<String?> getToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('token');
//   if (token == null || token.isEmpty) {
//     print('Token tidak ditemukan di SharedPreferences.');
//   } else {
//     print('Token ditemukan: $token');
//   }
//   return token;
// }

//   Future<Map<String, dynamic>> getUserProfile() async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//          print('Token kosong atau null. Pastikan token tersimpan dengan benar.');
//         throw Exception('Token not found');
//       }
//       print('Token used: $token');

//       final response = await _apiClient.dio.get(
//         '/profile',
//         options: Options(
//           headers: {'Authorization': 'Bearer $token'},
//         ),
//       );

//       if (response.statusCode == 200 && response.data['success']) {
//         print('User profile fetched successfully.');
//         return response.data['user'];
//       } else {
//         print('Gagal mendapatkan profil user: ${response.data}');
//         throw Exception('Gagal mendapatkan profil user');
//       }
//     } catch (e) {
//       print('Error fetching user profile: $e');
//       throw Exception('Gagal mendapatkan profil user');
//     }
//   }

// Future<bool> updateUserProfile(Map<String, dynamic> data) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token');

//       final response = await _apiClient.dio.post(
//         '/profile/update',
//         data: data,
//         options: Options(
//           headers: {'Authorization': 'Bearer $token'},
//         ),
//       );

//       if (response.statusCode == 200 && response.data['success']) {
//         return true;
//       } else {
//         throw Exception(response.data['message'] ?? 'Gagal memperbarui profil');
//       }
//     } on DioError catch (e) {
//       print('Update error: ${e.response?.data}');
//       throw Exception('Gagal memperbarui profil');
//     }
//   }

//   Future<void> uploadProfilePhoto(File image) async {
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     if (token == null) {
//       throw Exception('Token not found');
//     }

//     FormData formData = FormData.fromMap({
//       "foto": await MultipartFile.fromFile(
//         image.path,
//         filename: image.path.split('/').last,
//       ),
//     });

//     Response response = await _apiClient.dio.post(
//       "/profile/update-photo",
//       data: formData,
//       options: Options(
//         headers: {
//           "Authorization": "Bearer $token",
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       print("Foto berhasil diunggah: ${response.data}");
//     } else {
//       print("Gagal mengunggah foto: ${response.data}");
//     }
//   } catch (e) {
//     print("Terjadi kesalahan saat upload foto: $e");
//   }
// }

// }
