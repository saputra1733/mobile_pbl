import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/login_screen.dart';
import 'package:mobile_pbl/screens/profile_dosen_screen.dart';
import 'package:mobile_pbl/services/activity_service.dart';
import 'package:mobile_pbl/models/activity_model.dart';
import 'package:mobile_pbl/widgets/footer.dart';
import 'package:mobile_pbl/screens/download_document_screen.dart';
import 'package:intl/intl.dart';

class ActivityListScreen extends StatefulWidget {
  const ActivityListScreen({super.key});

  @override
  State<ActivityListScreen> createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  final ActivityService _activityService = ActivityService();
  List<ActivityModel> _activities = [];
  bool _isLoading = true;
  String _error = '';
  final TextEditingController _searchController = TextEditingController();
  List<ActivityModel> _filteredActivities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final result = await _activityService.getActivityList();

      if (result['success']) {
        final List<dynamic> data = result['data'];
        try {
          setState(() {
            _activities = data.map((item) => ActivityModel.fromJson(item)).toList();
            _filteredActivities = _activities;
            _isLoading = false;
          });
        } catch (e) {
          setState(() {
            _error = e.toString();
            _isLoading = false;
          });
        }
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

  void _filterActivities(String query) {
    setState(() {
      _filteredActivities = _activities.where((activity) {
        if (activity.kegiatan == null) return false;

        final namaKegiatan = activity.kegiatan!.namaKegiatan.toLowerCase();
        final deskripsi = activity.kegiatan!.deskripsiKegiatan.toLowerCase();
        final nomorSurat = activity.nomerSurat?.toLowerCase() ?? '';
        final judulSurat = activity.judulSurat?.toLowerCase() ?? '';

        return namaKegiatan.contains(query.toLowerCase()) ||
            deskripsi.contains(query.toLowerCase()) ||
            nomorSurat.contains(query.toLowerCase()) ||
            judulSurat.contains(query.toLowerCase());
      }).toList();
    });
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
              Navigator.pushNamed(context, '/profile-dosen');
            },
            child: const Text('PROFILE', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('LOGOUT', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterActivities,
              decoration: InputDecoration(
                hintText: 'Cari Kegiatan',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),

          // List of Activities
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error.isNotEmpty
                    ? Center(child: Text(_error))
                    : _filteredActivities.isEmpty
                        ? const Center(
                            child: Text('Tidak ada kegiatan ditemukan'))
                        : ListView.builder(
                            itemCount: _filteredActivities.length,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            itemBuilder: (context, index) {
                              final activity = _filteredActivities[index];
                              final kegiatan = activity.kegiatan;

                              return Card(
                                margin: const EdgeInsets.only(bottom: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DownloadDocumentScreen(activity: activity)),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                activity.judulSurat ??
                                                    'Tidak ada judul',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            if (kegiatan != null &&
                                                kegiatan.statusKegiatan !=
                                                    '')
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      kegiatan.statusKegiatan
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'selesai'
                                                          ? Colors.green
                                                          : Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  kegiatan.statusKegiatan
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'No. Surat: ${activity.nomerSurat ?? '-'}',
                                          style:
                                              const TextStyle(color: Colors.grey),
                                        ),
                                        if (activity.fileSurat != null) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            'File: ${activity.fileSurat}',
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                        if (activity.tanggalSurat !=
                                            null) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            'Tanggal Surat: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(activity.tanggalSurat!))}',
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                        if (kegiatan != null) ...[
                                          const SizedBox(height: 16),
                                          const Text(
                                            'Detail Kegiatan:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                              'Nama: ${kegiatan.namaKegiatan ?? '-'}'),
                                          Text(
                                              'Lokasi: ${kegiatan.lokasiKegiatan ?? '-'}'),
                                          Text(
                                              'Penyelenggara: ${kegiatan.penyelenggara ?? '-'}'),
                                          if (kegiatan.tanggalMulai != null &&
                                              kegiatan.tanggalSelesai != null)
                                            Text(
                                              'Periode: ${DateFormat('dd MMM yyyy').format(DateTime.parse(kegiatan.tanggalMulai!))} - ${DateFormat('dd MMM yyyy').format(DateTime.parse(kegiatan.tanggalSelesai!))}',
                                            ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
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
