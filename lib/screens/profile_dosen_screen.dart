import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/edit_profile_dosen_screen.dart';
import 'package:mobile_pbl/screens/login_screen.dart';
import 'package:mobile_pbl/widgets/footer.dart';
import 'package:mobile_pbl/services/api_profile.dart';

class ProfileDosenScreen extends StatefulWidget {
  const ProfileDosenScreen({super.key});

  @override
  _ProfileDosenScreenState createState() => _ProfileDosenScreenState();
}

class _ProfileDosenScreenState extends State<ProfileDosenScreen> {
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    final apiProfile = ApiProfile();
    final result = await apiProfile.fetchProfile();

    print('Profile Data: $result');

    if (result['success']) {
      setState(() {
        _profileData = result['data'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('PROFILE'),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileDosenScreen()),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('EDIT'),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('LOGOUT'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CircleAvatar(
  radius: 50,
  backgroundColor: Colors.brown.shade300,
  backgroundImage: _profileData != null &&
          _profileData!['foto'] != null &&
          _profileData!['foto'].startsWith('data:image')
      ? MemoryImage(
          base64Decode(
              _profileData!['foto'].split(',').last)) // Hapus header Base64
      : null,
  child: _profileData?['foto'] == null
      ? const Icon(
          Icons.photo,
          size: 50,
          color: Colors.white,
        )
      : null,
),

                            const SizedBox(height: 8),
                            Text(
                              '${_profileData?['gelar_depan'] ?? ''} ${_profileData?['nama_lengkap'] ?? ''} ${_profileData?['gelar_belakang'] ?? ''}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildProfileForm(context),
                ],
              ),
            ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildProfileForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildFormField('Username', _profileData?['username']),
          _buildFormField('Nama Lengkap', _profileData?['nama_lengkap']),
          _buildFormField('NIDN', _profileData?['nidn']),
          _buildFormField('Jenis Kelamin', _profileData?['jenis_kelamin']),
          _buildFormField('Tempat, Tanggal Lahir',
              '${_profileData?['tempat_lahir']}, ${_profileData?['tanggal_lahir']}'),
          _buildFormField('Agama', _profileData?['agama']),
          _buildFormField('Alamat', _profileData?['alamat']),
          _buildFormField('Program Studi', _profileData?['program_studi']),
          _buildFormField(
              'Jabatan Fungsional', _profileData?['jabatan_fungsional']),
          _buildFormField(
              'Pendidikan Terakhir', _profileData?['pendidikan_terakhir']),
          _buildFormField('Status Pernikahan', _profileData?['status_nikah']),
          _buildFormField(
              'Status Ikatan Kerja', _profileData?['status_ikatan_kerja']),
          _buildFormField('Email', _profileData?['email']),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              value ?? '[Data tidak tersedia]',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}