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
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  final ApiLogin _apiService = ApiLogin();

  void _login() async {
  if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
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
  );

  setState(() {
    _isLoading = false;
  });

  if (response['success']) {
    print(response['user']['level_id']);
    // Redirect pengguna berdasarkan level
    if (response['user']['level_id'] == 3) {
      print('redirect to dosen');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardDosenScreen()),
      );
    } else if (response['user']['level_id'] == 2) {
      print('redirect to kaprodi');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardKaprodiScreen()),
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
            // Image.network(
            //   'https://upload.wikimedia.org/wikipedia/id/4/4a/Logo_Politeknik_Negeri_Malang.png',
            //   height: 50,
            // ),
            const SizedBox(width: 20),
            // const Text(
            //   'Sistem Informasi Manajemen SDM',
            //   style: TextStyle(fontSize: 15),
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
              'https://upload.wikimedia.org/wikipedia/id/4/4a/Logo_Politeknik_Negeri_Malang.png',
              height: 75,
              ),
              const SizedBox(height: 20),
              const Text(
                'Selamat Datang',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
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
      bottomNavigationBar: const FooterLogin(),
    );
  }
}