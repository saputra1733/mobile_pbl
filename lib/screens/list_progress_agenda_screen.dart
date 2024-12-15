import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/login_screen.dart';
import 'package:mobile_pbl/screens/profile_dosen_screen.dart';
import 'package:mobile_pbl/screens/riwayat_agenda.dart';
import 'package:mobile_pbl/services/agenda_service.dart';
import 'package:mobile_pbl/widgets/agenda_card.dart';
import 'package:mobile_pbl/widgets/footer.dart';

class ListProgressAgenda extends StatefulWidget {
  const ListProgressAgenda({super.key});

  @override
  State<ListProgressAgenda> createState() => _ListProgressAgendaState();
}

class _ListProgressAgendaState extends State<ListProgressAgenda> {
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
    print(_agendas);
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RiwayatAgenda()),
                    );
                  },
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
                hintText: 'Cari Progress',
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
                  ? ListView(
                      children: const [
                        AgendaCard(
                          title: 'Seminar Akademik',
                          subtitle: 'Basic Programmer',
                          progress: 100,
                          date: '20/4/2024',
                          fileName: 'DOC-001.pdf',
                          status: 'Selesai',
                          statusColor: Colors.green,
                        ),
                        AgendaCard(
                          title: 'Workshop Flutter',
                          subtitle: 'Basic Flutter UI',
                          progress: 50,
                          date: '21/4/2024',
                          fileName: 'DWSC-002.pdf',
                          status: 'Sedang Berlangsung',
                          statusColor: Colors.orange,
                        ),
                        AgendaCard(
                          title: 'Seminar Akademik',
                          subtitle: 'Basic Programmer',
                          progress: 100,
                          date: '20/4/2024',
                          fileName: 'DOC-001.pdf',
                          status: 'Selesai',
                          statusColor: Colors.green,
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: _agendas.length,
                      itemBuilder: (context, index) {
                        final agenda = _agendas[index];
                        final namaKegiatan = agenda['nama_kegiatan_jurusan'] ?? 
                                          agenda['nama_kegiatan_program_studi'] ?? 
                                          'Tidak ada nama';
                        
                        String status = agenda['status_kegiatan'] ?? '';
                        Color statusColor;
                        
                        switch (status.toLowerCase()) {
                          case 'selesai':
                            statusColor = Colors.green;
                            break;
                          case 'berlangsung':
                            statusColor = Colors.blue;
                            break;
                          default:
                            statusColor = Colors.orange;
                            status = 'Sedang Berlangsung';
                        }

                        String subtitle = agenda['agenda_aktif']['nama_agenda'] ?? '';
                        if (subtitle.length > 25) {
                          subtitle = '${subtitle.substring(0, 20)}...';
                        }

                        String filename = agenda['agenda_aktif']['file_surat_agenda'] ?? '';
                        if (filename.length > 40) {
                          filename = '${filename.substring(38)}...';
                        }

                        return AgendaCard(
                          title: namaKegiatan,
                          subtitle: subtitle,
                          progress: agenda['agenda_aktif']['progres'] ?? 0,
                          date: agenda['agenda_aktif']['tanggal_agenda'] ?? '',
                          fileName: filename,
                          status: status,
                          statusColor: statusColor,
                        );
                      },
                    ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
