import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/dashboard_dosen_screen.dart';
import 'package:mobile_pbl/screens/list_progress_agenda_screen.dart';
import 'package:mobile_pbl/screens/update_progress.dart';

class FooterKaprodi extends StatelessWidget {
  const FooterKaprodi({super.key});

  @override
  Widget build(BuildContext context) {
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
                        builder: (context) => const DashboardDosenScreen()),
                  );
                },
              ),
              const Text('Home', style: TextStyle(fontSize: 5)),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: Image.asset('assets/icons/progress.png', height: 24),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListProgressAgenda()),
                  );
                  // Navigasi ke Progress Kegiatan
                },
              ),
              const Text('Progress', style: TextStyle(fontSize: 5)),
            ],
          ),
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
                  // Navigasi ke Update Agenda
                },
              ),
              const Text('Update', style: TextStyle(fontSize: 5)),
            ],
          )
        ],
      ),
    );
  }
}
