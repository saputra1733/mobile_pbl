import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/dashboard_dosen_screen.dart';
import 'package:mobile_pbl/screens/dashboard_kaprodi_screen.dart';
import 'package:mobile_pbl/services/api_login.dart';
import 'package:mobile_pbl/widgets/footer_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedLevel;
  bool _isLoading = false;
  final ApiLogin _apiService = ApiLogin();

  void _login() async {
  if (_selectedLevel == null || _usernameController.text.isEmpty || _passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Semua field wajib diisi')),
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  final response = await _apiService.login(
    _usernameController.text,
    _passwordController.text,
    _selectedLevel!,
  );

  setState(() {
    _isLoading = false;
  });

  if (response['success']) {
    // Redirect pengguna berdasarkan level
    if (_selectedLevel == '3') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardDosenScreen()),
      );
    } else if (_selectedLevel == '2') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardKaprodiScreen()),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response['message'] ?? 'Login gagal')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3366CC),
        title: Row(
          children: [
            Image.network(
              'https://upload.wikimedia.org/wikipedia/id/4/4a/Logo_Politeknik_Negeri_Malang.png',
              height: 50,
            ),
            const SizedBox(width: 20),
            const Text(
              'Sistem Informasi Manajemen SDM',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Selamat Datang',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Level',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: '3', child: Text('Dosen')),
                  DropdownMenuItem(value: '2', child: Text('Kaprodi')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedLevel = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('LOGIN'),
                          SizedBox(width: 5),
                          Icon(Icons.login),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FooterLogin(),
    );
  }
}
