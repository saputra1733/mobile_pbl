import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mobile_pbl/screens/login_screen.dart';
import 'package:mobile_pbl/screens/profile_dosen_screen.dart';
import 'package:mobile_pbl/widgets/footer.dart';
import 'package:mobile_pbl/widgets/dashboard_dosen_card.dart';
import 'package:mobile_pbl/services/api_dashboard.dart';

class DashboardDosenScreen extends StatefulWidget {
  const DashboardDosenScreen({super.key});

  @override
  _DashboardDosenScreenState createState() => _DashboardDosenScreenState();
}

class _DashboardDosenScreenState extends State<DashboardDosenScreen> {
  Map<String, dynamic>? _profilData;
  Map<String, dynamic>? _statistikData;
  List<dynamic>? _agendaData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    final apiDashboard = ApiDashboard();
    final result = await apiDashboard.fetchDashboardData();

    if (result['success']) {
      setState(() {
        _profilData = result['data']['profil'];
        _statistikData = result['data']['statistik'];
        _agendaData = result['data']['agenda'];
        _isLoading = false;
      });

      if (_profilData != null && _profilData!['foto'] != null) {
        String imageBase64 = _profilData!['foto'];
        // Remove the Data URL prefix if it exists
        if (imageBase64.contains(',')) {
          imageBase64 = imageBase64.split(',')[1];
        }
        final decodedBytes = base64Decode(imageBase64);

        setState(() {
          _profilData?['fotoMemory'] = MemoryImage(decodedBytes);
        });

        final image = MemoryImage(decodedBytes);
        setState(() {
          _profilData?['foto'] = image;
        });
      }
      print('Profil data: $_profilData');
      print('Agenda data: $_agendaData');
      print('Statistik data: $_statistikData');
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
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileDosenScreen()),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat datang, ${_profilData?['nama_lengkap'] ?? '[nama lengkap user]'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DashboardCard(
                            title: 'Total Kegiatan',
                            count:
                                _statistikData?['total_kegiatan']?.toString() ??
                                    '[jumlah]'),
                        DashboardCard(
                            title: 'Kegiatan Selesai',
                            count: _statistikData?['kegiatan_selesai']
                                    ?.toString() ??
                                '[jumlah]'),
                        DashboardCard(
                            title: 'Kegiatan Berjalan',
                            count: _statistikData?['kegiatan_berjalan']
                                    ?.toString() ??
                                '[jumlah]'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: _profilData?['fotoMemory'] ??
                                             const AssetImage('assets/image/default_avatar.png'), // Provide a default image here
                            backgroundColor: Colors.brown,
                            child: _profilData?['fotoMemory'] == null
                                ? const Icon(Icons.person, size: 40)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _profilData?['nama_lengkap'] ??
                                    '[nama lengkap]',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'NIDN: ${_profilData?['nidn'] ?? '[nomer NIDN]'}'),
                              Text(
                                  '${_profilData?['program_studi'] ?? '[nama program studi]'}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...(_agendaData ?? []).asMap().entries.map((entry) {
                      final index = entry.key;
                      final agenda = entry.value;
                      String? nama_kegiatan = '[nama kegiatan]';
                      if (agenda['kegiatan_institusi'] != null) {
                        nama_kegiatan = agenda['kegiatan_institusi']
                            ['nama_kegiatan_institusi'];
                      } else if (agenda['kegiatan_luar_institusi'] != null) {
                        nama_kegiatan = agenda['kegiatan_luar_institusi']
                            ['nama_kegiatan_luar_institusi'];
                      } else if (agenda['kegiatan_jurusan'] != null) {
                        nama_kegiatan =
                            agenda['kegiatan_jurusan']['nama_kegiatan_jurusan'];
                      } else if (agenda['kegiatan_program_studi'] != null) {
                        nama_kegiatan = agenda['kegiatan_program_studi']
                            ['nama_kegiatan_program_studi'];
                      }
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nama_kegiatan ?? '[nama kegiatan]',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(agenda['nama_agenda'] ?? '[nama Agenda]'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(agenda['tanggal_agenda'] ??
                                    '[tanggal agenda]'),
                                Text(
                                    'Agenda ${index + 1}/${agenda['total_agenda'] ?? 1}'),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: const Footer(),
    );
  }
}