import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/agenda_nonjti.dart';
import 'package:mobile_pbl/screens/login_screen.dart';
import 'package:mobile_pbl/screens/profile_dosen_screen.dart';
import 'package:mobile_pbl/widgets/footer.dart';

class RiwayatNonjti extends StatelessWidget {
  const RiwayatNonjti({super.key});

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
                  builder: (context) => const ProfileDosenScreen(),
                ),
              );
            },
            child: const Text('PROFILE', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
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
                  const SizedBox(width: 45),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgendaNonjti(),
                      ),
                    );
                  },
                  child: const Text(
                    'Input Kegiatan',
                    style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 110),
                TextButton(
                  onPressed: () {}, // Tetap di Riwayat
                  child: const Text(
                    'Riwayat',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Kotak pencarian
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 197, 197, 197),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Cari Kegiatan",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                ),
              ),
            ),
          ),

          // Daftar kegiatan
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                buildKegiatanCard(
                  "Seminar Akademik",
                  "20/4/2024",
                  "22/4/2024",
                  "Drs. Andi",
                ),
                buildKegiatanCard(
                  "Workshop",
                  "20/4/2024",
                  "22/4/2024",
                  "Drs. Andi",
                ),
                buildKegiatanCard(
                  "Rapat Paripurna",
                  "20/4/2024",
                  "22/4/2024",
                  "Drs. Andi",
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  // Widget untuk membuat card kegiatan
  Widget buildKegiatanCard(
      String title, String startDate, String endDate, String pic) {
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
