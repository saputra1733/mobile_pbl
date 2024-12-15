import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/activity_list_screen.dart';
import 'package:mobile_pbl/screens/dashboard_dosen_screen.dart';
import 'package:mobile_pbl/screens/dashboard_kaprodi_screen.dart';
import 'package:mobile_pbl/screens/list_progress_agenda_screen.dart';
import 'package:mobile_pbl/screens/update_progress.dart';
import 'package:mobile_pbl/services/api_profile.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<String> getRole() async {
    // fetch profile
    final profile = await ApiProfile().fetchProfile();
    
    return profile['data']['level_nama'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getRole(), // Get the role asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Loading indicator while fetching role
        }

        if (!snapshot.hasData) {
          return const Center(child: Text("Failed to load role"));
        }

        String role = snapshot.data!;

        return BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Image.asset('assets/icons/home.png', height: 24),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => role == 'Dosen'
                                ? const DashboardDosenScreen()
                                : const DashboardKaprodiScreen()), // Navigate based on role
                      );
                    },
                  ),
                  const Text('Home', style: TextStyle(fontSize: 5)),
                ],
              ),
              if (role == 'Dosen') // Show Progress for Dosen only
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/progress.png', height: 24),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ListProgressAgenda()),
                        );
                      },
                    ),
                    const Text('Progress', style: TextStyle(fontSize: 5)),
                  ],
                ),
              if (role == 'Dosen') // Show Update for both roles
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/update.png', height: 28),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UpdateProgressPage()),
                        );
                      },
                    ),
                    const Text('Update', style: TextStyle(fontSize: 5)),
                  ],
                ),
              if (role == 'Kaprodi') // Show Update for both roles
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/update.png', height: 28),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ActivityListScreen()),
                        );
                      },
                    ),
                    const Text('Kegiatan', style: TextStyle(fontSize: 5)),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
