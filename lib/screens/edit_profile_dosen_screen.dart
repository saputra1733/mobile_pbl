import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/login_screen.dart';
import 'package:mobile_pbl/widgets/footer.dart';

class EditProfileDosenScreen extends StatelessWidget {
  const EditProfileDosenScreen({super.key});

  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context), // Kirim context ke _buildHeader
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
        'Edit Profile',
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
              backgroundColor: const Color.fromRGBO(9, 109, 225, 1),
              foregroundColor: Colors.white,
            ),
            child: const Text('PROFILE'),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              // Gunakan Navigator.push dengan context yang valid
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
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
  );
}


  Widget _buildProfilePhoto() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.brown[300],
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '[tempat foto]',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(9, 109, 225, 1),
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildFormField('Username')),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('Jabatan Fungsional')),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildFormField('Gelar Depan')),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('Program Studi')),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildFormField('Nama Lengkap')),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('Pendidikan Terakhir')),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildFormField('Gelar Belakang')),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('Status Pernikahan')),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildFormField('NIDN')),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('Status Ikatan Kerja')),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildFormField('Jenis Kelamin')),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('Email')),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildFormField('Tempat Lahir')),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('Tanggal Lahir')),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildFormField('Agama')),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('Asal Perguruan Tinggi')),
          ],
        ),
        _buildFormField('Alamat', fullWidth: true),
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

  Widget _buildFormField(String label, {bool fullWidth = false}) {
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
          Container(
            width: fullWidth ? double.infinity : null,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
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