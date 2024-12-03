import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/agenda_nonjti.dart';
import 'package:flutter_application_4/screens/dashboard_dosen_screen.dart';
import 'package:flutter_application_4/screens/list_progress_agenda_screen.dart';
import 'package:flutter_application_4/screens/update_progress.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

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
                        builder: (context) => DashboardDosenScreen()),
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
                    MaterialPageRoute(builder: (context) => ListProgressAgenda()),
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
                        builder: (context) => UpdateProgressPage()),
                  );
                  // Navigasi ke Update Agenda
                },
              ),
              const Text('Update', style: TextStyle(fontSize: 5)),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: Image.asset('assets/icons/nonjti.png', height: 24),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AgendaNonjti()),
                  );
                },
              ),
              const Text('Non JTI', style: TextStyle(fontSize: 5)),
            ],
          ),
        ],
      ),
    );
  }
}
