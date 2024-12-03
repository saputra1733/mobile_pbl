import 'package:flutter/material.dart';
import '../widgets/footer.dart';
import '../widgets/prevent_overflow_widget.dart';

class ActivityListScreen extends StatelessWidget {
  const ActivityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreventOverflowWidget(
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text("POLINEMA", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 1,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("PROFILE"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Logika logout (opsional)
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("LOGOUT"),
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Daftar Kegiatan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Cari kegiatan",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Aksi pencarian
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      child: const Icon(Icons.search, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      _buildActivityItem("Seminar Akademik", "20-6-2024", "Selesai", Colors.green),
                      _buildActivityItem("Rapat Kurikulum", "20-6-2024", "Terjadwal", Colors.yellow),
                      _buildActivityItem("Rapat Akademik", "20-6-2024", "Sedang Berlangsung", Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const Footer(),
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String date, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(date, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(status, style: TextStyle(color: statusColor)),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Aksi unduh dokumen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.download, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
