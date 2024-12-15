import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pbl/screens/list_progress_agenda_screen.dart';
import 'package:mobile_pbl/screens/login_screen.dart';
import 'package:mobile_pbl/screens/profile_dosen_screen.dart';
import 'package:mobile_pbl/widgets/footer.dart';
import 'package:mobile_pbl/widgets/upload_file.dart';
import 'package:mobile_pbl/services/api_update_progress.dart';

class UpdateProgressPage extends StatefulWidget {
  const UpdateProgressPage({super.key});

  @override
  State<UpdateProgressPage> createState() => _UpdateProgressPageState();
}

class _UpdateProgressPageState extends State<UpdateProgressPage> {
  final UpdateProgressService _service = UpdateProgressService();
  List<Map<String, dynamic>> kegiatanList = [];
  List<Map<String, dynamic>> agendaList = [];
  Map<String, dynamic>? selectedKegiatan;
  Map<String, dynamic>? selectedAgenda;
  int? selectedProgress;
  bool isLoading = true;
  String? errorMessage;

  http.MultipartFile? selectedFile;

  @override
  void initState() {
    super.initState();
    fetchKegiatan();
  }

  Future<void> fetchKegiatan() async {
    try {
      final result = await _service.getKegiatanList();
      setState(() {
        isLoading = false;
        if (result['success']) {
          kegiatanList =
              List<Map<String, dynamic>>.from(result['data']['agendas']);
        } else {
          errorMessage = result['message'];
        }

        selectedAgenda = null;
        selectedProgress = null;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
    }
  }

  void updateAgendaList() {
    if (selectedKegiatan != null) {
      setState(() {
        agendaList =
            List<Map<String, dynamic>>.from(selectedKegiatan!['agenda']);
        selectedAgenda = null;
        selectedProgress = null;
      });
    }
  }

  Future<void> updateProgress() async {
    if (selectedAgenda == null || selectedProgress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Silakan lengkapi semua field yang diperlukan')),
      );
      return;
    }

    try {
      print('Agenda ID: ${selectedAgenda!['agenda_id']}');
      print('Progress: $selectedProgress');
      print('File: $selectedFile');

      final result = await _service.updateProgress(
        selectedAgenda!['agenda_id'],
        selectedProgress!,
        selectedFile,
      );

      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'])),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ListProgressAgenda()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'])),
        );
      }
    } catch (e) {
      selectedFile = null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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
          Container(
            color: Colors.blue[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Form Update',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Update Progress Agenda',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Silahkan Lengkapi Form Berikut',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    if (isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (errorMessage != null)
                      Center(
                          child: Text(errorMessage!,
                              style: const TextStyle(color: Colors.red)))
                    else ...[
                      const Text('Kegiatan'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<Map<String, dynamic>>(
                        items: kegiatanList.map((kegiatan) {
                          // Tentukan nama kegiatan secara dinamis
                          final namaKegiatan =
                              kegiatan['nama_kegiatan_jurusan'] ??
                                  kegiatan['nama_kegiatan_program_studi'] ??
                                  'Tidak ada nama';

                          return DropdownMenuItem(
                            value: kegiatan,
                            child: Text(
                                namaKegiatan), // Gunakan nama kegiatan yang sudah dinamis
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedKegiatan = value;
                            selectedAgenda = null;
                            updateAgendaList();
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 197, 197, 197),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text('Pilih Agenda'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<Map<String, dynamic>>(
                        items: agendaList
                            .map((agenda) => DropdownMenuItem(
                                  value: agenda,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: 200), // Batas lebar
                                    child: Text(
                                      agenda['nama_agenda'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedAgenda = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 197, 197, 197),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text('Progress (%)'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<int>(
                        items: [0, 25, 50, 75, 100]
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text('$value'),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedProgress = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 197, 197, 197),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text('Upload Berkas'),
                      const SizedBox(height: 8),
                      UploadFile(
                        onFileChanged: (file) {
                          setState(() {
                            selectedFile = file;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: updateProgress,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                          ),
                          child: const Text(
                            'Simpan Progress',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
