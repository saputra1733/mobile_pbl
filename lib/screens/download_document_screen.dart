import 'package:flutter/material.dart';
import 'package:mobile_pbl/models/activity_model.dart';
import 'package:mobile_pbl/widgets/footer.dart';
import '../widgets/prevent_overflow_widget.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadDocumentScreen extends StatelessWidget {
  final ActivityModel activity;

  const DownloadDocumentScreen({
    super.key,
    required this.activity,
  });

  Future<void> _downloadFile() async {
    if (activity.fileSurat != null) {
      final url = 'http://192.168.100.12:8000/storage/${activity.fileSurat}';
      if (!await launchUrl(Uri.parse(url))) {
        throw Exception('Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final kegiatan = activity.kegiatan;

    return PreventOverflowWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "POLINEMA",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/profile-dosen'),
              child: const Text('PROFILE', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text('LOGOUT', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.judulSurat ?? 'Tidak ada judul',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Nomor Surat: ${activity.nomerSurat ?? '-'}'),
                      if (activity.tanggalSurat != null)
                        Text(
                          'Tanggal Surat: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(activity.tanggalSurat!))}',
                        ),
                      const SizedBox(height: 24),
                      if (activity.fileSurat != null) ...[
                        ElevatedButton.icon(
                          onPressed: _downloadFile,
                          icon: const Icon(Icons.download),
                          label: const Text('Download Surat'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (kegiatan != null) ...[
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detail Kegiatan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Nama Kegiatan: ${kegiatan.namaKegiatan}'),
                        Text('Deskripsi: ${kegiatan.deskripsiKegiatan}'),
                        Text('Lokasi: ${kegiatan.lokasiKegiatan}'),
                        Text('Penyelenggara: ${kegiatan.penyelenggara}'),
                        Text('Status: ${kegiatan.statusKegiatan}'),
                        if (kegiatan.tanggalMulai != null && kegiatan.tanggalSelesai != null)
                          Text(
                            'Periode: ${DateFormat('dd MMM yyyy').format(DateTime.parse(kegiatan.tanggalMulai!))} - ${DateFormat('dd MMM yyyy').format(DateTime.parse(kegiatan.tanggalSelesai!))}',
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }
}
