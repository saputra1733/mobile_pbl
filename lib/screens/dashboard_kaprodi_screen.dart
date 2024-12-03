import 'package:flutter/material.dart';
import '../widgets/footer.dart';
// import '../widgets/prevent_overflow_widget.dart';


class DashboardKaprodiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Dashboard", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile'); // Navigasi ke Profil
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
              // Tambahkan logika logout di sini
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Selamat datang, John Doe", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: const Text("FOTO", style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("(Nama Lengkap)", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("NIDN: (Nomor NIDN)"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildStatistikBebanKerjaSection(),
            const SizedBox(height: 16),
            _buildKegiatanTerbaruSection(),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),

    );
  }

  Widget _buildStatistikBebanKerjaSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Statistik Beban Kerja Dosen", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton<String>(
                value: "2024",
                onChanged: (value) {},
                items: ["2024"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: "Semester ganjil",
                onChanged: (value) {},
                items: ["Semester ganjil"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  print("Unduh file");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                ),
                child: const Text("Unduh file", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text("Grafik Visualisasi Beban Kerja", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBarChart("Dr. Andi Wijaya", 50),
              _buildBarChart("Dr. Citra Lestari", 100),
              _buildBarChart("Dr. Kurnia", 150),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(String label, double height) {
    return Column(
      children: [
        Container(
          width: 30,
          height: height,
          color: Colors.blue,
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildKegiatanTerbaruSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Kegiatan Terbaru", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildKegiatanItem("(nama kegiatan)", "Tanggal"),
          _buildKegiatanItem("(nama kegiatan)", "Tanggal"),
          _buildKegiatanItem("(nama kegiatan)", "Tanggal"),
        ],
      ),
    );
  }

  Widget _buildKegiatanItem(String namaKegiatan, String tanggal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(namaKegiatan),
          Text(tanggal),
        ],
      ),
    );
  }
}
