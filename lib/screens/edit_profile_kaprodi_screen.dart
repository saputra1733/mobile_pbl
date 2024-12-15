import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/login_screen.dart';
import 'package:mobile_pbl/screens/profile_kaprodi_screen.dart';
import 'package:mobile_pbl/widgets/footer.dart';
import 'package:mobile_pbl/services/api_profile.dart';

class EditProfileKaprodiScreen extends StatefulWidget {
  const EditProfileKaprodiScreen({super.key});

  @override
  _EditProfileKaprodiScreenState createState() => _EditProfileKaprodiScreenState();
}

class _EditProfileKaprodiScreenState extends State<EditProfileKaprodiScreen> {
  Map<String, dynamic>? _profileData;
  late Map<String, TextEditingController> controllers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    final apiProfile = ApiProfile();
    final result = await apiProfile.fetchProfile();

    if (result['success']) {
      _profileData = result['data'];
      _initializeControllers(_profileData!);
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }

  void _initializeControllers(Map<String, dynamic> data) {
    data.forEach((key, value) {
      controllers[key] ??= TextEditingController(text: value?.toString() ?? '');
    });
  }

  @override
  void dispose() {
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildProfilePhoto(),
              const SizedBox(height: 20),
              _buildProfileForm(),
              const SizedBox(height: 20),
              _buildPasswordSection(),
              const SizedBox(height: 20),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Edit Profile Kaprodi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'PROFILE',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'LOGOUT',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }

  Widget _buildProfilePhoto() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.brown.shade300,
          backgroundImage: _profileData != null &&
                  _profileData!['foto'] != null &&
                  _profileData!['foto'].startsWith('data:image')
              ? MemoryImage(base64Decode(
                  _profileData!['foto'].split(',').last)) // Remove Base64 header
              : null,
          child: _profileData?['foto'] == null
              ? const Icon(
                  Icons.photo,
                  size: 50,
                  color: Colors.white,
                )
              : null,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text('Pilih Foto'),
        ),
        const Text(
          'Format: JPG, JPEG, PNG (Max: 2MB)',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProfileForm() {
    if (_profileData == null || controllers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                'Username',
                controller: controllers['username'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                'Jabatan Fungsional',
                controller: controllers['jabatan_fungsional'],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                'Gelar Depan',
                controller: controllers['gelar_depan'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                'Program Studi',
                controller: controllers['program_studi'],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                'Nama Lengkap',
                controller: controllers['nama_lengkap'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                'Pendidikan Terakhir',
                controller: controllers['pendidikan_terakhir'],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                'Gelar Belakang',
                controller: controllers['gelar_belakang'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                'Status Pernikahan',
                controller: controllers['status_nikah'],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                'NIDN',
                controller: controllers['nidn'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                'Status Ikatan Kerja',
                controller: controllers['status_ikatan_kerja'],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                'Jenis Kelamin',
                controller: controllers['jenis_kelamin'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                'Email',
                controller: controllers['email'],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                'Tempat Lahir',
                controller: controllers['tempat_lahir'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                'Tanggal Lahir',
                controller: controllers['tanggal_lahir'],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                'Agama',
                controller: controllers['agama'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                'Asal Perguruan Tinggi',
                controller: controllers['asal_perguruan_tinggi'],
              ),
            ),
          ],
        ),
        _buildFormField(
          'Alamat',
          fullWidth: true,
          controller: controllers['alamat'],
        ),
      ],
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ganti Password',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildFormField('Password Saat ini'),
        Row(
          children: [
            Expanded(child: _buildFormField('Password Baru')),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('Konfirmasi password')),
          ],
        ),
      ],
    );
  }

  Widget _buildFormField(String label,
      {bool fullWidth = false,
      TextEditingController? controller,
      Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfile() async {
    final apiProfile = ApiProfile();
    final result = await apiProfile.updateProfile(
      controllers.map((key, value) => MapEntry(key, value.text)),
    );
    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile berhasil diupdate.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Gagal mengupdate profile')),
      );
    }
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _updateProfile,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32),
          ),
          child: const Text('SIMPAN'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32),
          ),
          child: const Text('HAPUS'),
        ),
      ],
    );
  }
}
