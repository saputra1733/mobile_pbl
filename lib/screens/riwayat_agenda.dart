import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/login_screen.dart';
import 'package:mobile_pbl/screens/profile_dosen_screen.dart';
import 'package:mobile_pbl/services/agenda_service.dart';
import 'package:mobile_pbl/widgets/footer.dart';

class RiwayatAgenda extends StatefulWidget {
  const RiwayatAgenda({super.key});

  @override
  State<RiwayatAgenda> createState() => _RiwayatAgendaState();
}

class _RiwayatAgendaState extends State<RiwayatAgenda> {
  final AgendaService _agendaService = AgendaService();
  List<dynamic> _agendas = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadAgendas();
  }

  Future<void> _loadAgendas() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final result = await _agendaService.getAgendaList();

      if (result['success']) {
        setState(() {
          _agendas = result['data'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = result['message'];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'POLINEMA',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileDosenScreen()),
              );
            },
            child: const Text('PROFILE', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text('LOGOUT', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab selector
          Container(
            color: Colors.blue[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Hanya tombol "Daftar Progress"
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Daftar Kegiatan',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 80),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Riwayat',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Riwayat',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),

          // List of Agenda Cards
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error.isNotEmpty
                    ? Center(child: Text(_error))
                    : _agendas.isEmpty
                        ? const Center(child: Text("No agendas found"))
                        : ListView.builder(
                            itemCount: _agendas.length,
                            itemBuilder: (context, index) {
                              final agenda = _agendas[index];
                              final namaKegiatan =
                                  agenda['nama_kegiatan_jurusan'] ??
                                      agenda['nama_kegiatan_program_studi'] ??
                                      'Tidak ada nama';

                              String pic = agenda['user']['nama_lengkap'] ?? '';
                              if (pic.length > 20) {
                                pic = '${pic.substring(0, 20)}...';
                              }

                              String subtitle = agenda['agenda_aktif']
                                          ['nama_agenda'] ??
                                      '';
                              if (subtitle.length > 25) {
                                subtitle = '${subtitle.substring(0, 20)}...';
                              }

                              String filename =
                                  agenda['agenda_aktif']['file_surat_agenda'] ??
                                      '';
                              if (filename.length > 40) {
                                filename = '${filename.substring(38)}...';
                              }

                              return buildKegiatanCard(
                                namaKegiatan,
                                agenda['tanggal_mulai'] ?? '',
                                agenda['tanggal_selesai'] ?? '',
                                agenda['agenda_aktif']['progress'] ?? 0,
                                pic
                              );
                            },
                          ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  // Existing buildKegiatanCard method
  Widget buildKegiatanCard(
      String title, String startDate, String endDate, int progress, String pic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 8),
              Text("Mulai: $startDate"),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16),
              const SizedBox(width: 8),
              Text("Selesai: $endDate"),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.person, size: 16),
              const SizedBox(width: 8),
              Text("PIC: $pic"),
            ],
          ),
        ],
      ),
    );
  }
}
