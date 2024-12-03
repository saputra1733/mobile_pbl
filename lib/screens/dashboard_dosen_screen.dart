import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/login_screen.dart';
import 'package:flutter_application_4/screens/profile_dosen_screen.dart';
import 'package:flutter_application_4/widgets/footer.dart';
import 'package:flutter_application_4/widgets/dashboard_dosen_card.dart';
import 'package:flutter_application_4/services/api_dashboard.dart';

class DashboardDosenScreen extends StatefulWidget {
  @override
  _DashboardDosenScreenState createState() => _DashboardDosenScreenState();
}

class _DashboardDosenScreenState extends State<DashboardDosenScreen> {
  Map<String, dynamic>? _profilData;
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
        _agendaData = result['data']['agenda'];
        _isLoading = false;
      });

      print('Profil data: $_profilData');
    print('Agenda data: $_agendaData');
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
                MaterialPageRoute(builder: (context) => ProfileDosenScreen()),
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
                MaterialPageRoute(builder: (context) => LoginScreen()),
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
                            count: _profilData?['statistik']['total_kegiatan']
                                    ?.toString() ??
                                '[jumlah]'),
                        DashboardCard(
                            title: 'Kegiatan Selesai',
                            count: _profilData?['statistik']['kegiatan_selesai']
                                    ?.toString() ??
                                '[jumlah]'),
                        DashboardCard(
                            title: 'Kegiatan Berjalan',
                            count: _profilData?['statistik']['kegiatan_berjalan']
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
                            backgroundImage: _profilData != null &&
                                    _profilData!['foto'] != null
                                ? NetworkImage(
                                    'http://192.168.100.12:8000/uploads/${_profilData!['foto']}')
                                : null,
                            backgroundColor: Colors.brown,
                            child: _profilData?['foto'] == null
                                ? const Text('Foto')
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _profilData?['nama_lengkap'] ?? '[nama lengkap]',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text('NIDN: ${_profilData?['nidn'] ?? '[nomer NIDN]'}'),
                              Text(
                                  'Program Studi: ${_profilData?['program_studi'] ?? '[nama program studi]'}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...(_agendaData ?? [])
                        .asMap()
                        .entries
                        .map((entry) {
                          final index = entry.key;
                          final agenda = entry.value;
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
                                  agenda['nama_kegiatan'] ?? '[nama kegiatan]',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(agenda['nama_agenda'] ?? '[nama Agenda]'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                        })
                        .toList(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: const Footer(),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_application_4/screens/login_screen.dart';
// import 'package:flutter_application_4/screens/profile_dosen_screen.dart';
// import 'package:flutter_application_4/widgets/footer.dart';
// import 'package:flutter_application_4/widgets/dashboard_dosen_card.dart';
// import 'package:flutter_application_4/services/api_dashboard.dart';

// class DashboardDosenScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         centerTitle: true,
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfileDosenScreen()),
//               );
//             },
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.blue,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text(
//               'PROFILE',
//               style: TextStyle(color: Colors.white), 
//             ),
//           ),
//           const SizedBox(width: 10), 
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginScreen()),
//               );
//             },
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text(
//               'LOGOUT',
//               style: TextStyle(color: Colors.white), 
//             ),
//           ),
//           const SizedBox(width: 10), 
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Selamat datang, [nama lengkap user]',
//                 style: TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: const [
//                   DashboardCard(title: 'Total Kegiatan', count: '[jumlah]'),
//                   DashboardCard(title: 'Kegiatan Selesai', count: '[jumlah]'),
//                   DashboardCard(title: 'Kegiatan Berjalan', count: '[jumlah]'),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 40,
//                       backgroundColor: Colors.brown,
//                       child: const Text('Foto'),
//                     ),
//                     const SizedBox(width: 16),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           '[nama lengkap]',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Text('NIDN: [nomer NIDN]'),
//                         Text('Program Studi: [nama program studi]'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ...List.generate(3, (index) {
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 10.0),
//                   padding: const EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '[nama kegiatan]',
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const Text('[nama Agenda]'),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('[tanggal agenda]'),
//                           Text('Agenda [${index + 1}/5]'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const Footer(),
//     );
//   }
// }
