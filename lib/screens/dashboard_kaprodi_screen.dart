import 'package:flutter/material.dart';
import 'package:mobile_pbl/services/api_dashboard.dart';
import 'package:mobile_pbl/screens/profile_dosen_screen.dart';
import 'package:mobile_pbl/screens/login_screen.dart';
import '../widgets/footer.dart';

class DashboardKaprodiScreen extends StatefulWidget {
  const DashboardKaprodiScreen({super.key});

  @override
  _DashboardKaprodiScreenState createState() => _DashboardKaprodiScreenState();
}

class _DashboardKaprodiScreenState extends State<DashboardKaprodiScreen> {
  Map<String, dynamic>? _profilData;
  List<dynamic>? _recentActivities;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    final apiDashboard = ApiDashboard(); // Assuming ApiDashboard has a method to fetch dashboard data
    final result = await apiDashboard.fetchDashboardData();

    if (result['success']) {
      setState(() {
        _profilData = result['data']['profil'];
        _recentActivities = result['data']['recent_activities'];
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Dashboard", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileDosenScreen()),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting and Profile Info
                  Text(
                    'Selamat datang, ${_profilData?['nama_lengkap'] ?? '[nama lengkap user]'}',
                    style: const TextStyle(fontSize: 18),
                  ),
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
                          backgroundImage: _profilData?['foto'] != null
                              ? NetworkImage(_profilData!['foto'])
                              : null, // Show photo if available
                          backgroundColor: Colors.grey[300],
                          child: _profilData?['foto'] == null
                              ? const Text('FOTO', style: TextStyle(color: Colors.black))
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _profilData?['nama_lengkap'] ?? '[nama lengkap]',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('NIDN: ${_profilData?['nidn'] ?? '[Nomor NIDN]'}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Statistik Beban Kerja Section
                  _buildStatistikBebanKerjaSection(),

                  const SizedBox(height: 16),

                  // Recent Activities Section
                  _buildRecentActivitiesSection(),
                ],
              ),
            ),
      bottomNavigationBar: const Footer(),
    );
  }

  // Statistik Beban Kerja Section (unchanged)
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

  // Recent Activities Section
  Widget _buildRecentActivitiesSection() {
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
          if (_recentActivities != null && _recentActivities!.isNotEmpty)
            ..._recentActivities!.map((activity) {
              return _buildKegiatanItem(
                activity['nama_kegiatan'] ?? '[Nama Kegiatan]',
                activity['tanggal'] ?? '[Tanggal]',
              );
            }).toList(),
          if (_recentActivities == null || _recentActivities!.isEmpty)
            const Text('Tidak ada kegiatan terbaru'),
        ],
      ),
    );
  }

  // Kegiatan Item Widget
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
