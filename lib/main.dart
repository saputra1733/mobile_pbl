import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/dashboard_dosen_screen.dart';
import 'package:mobile_pbl/screens/edit_profile_dosen_screen.dart';
import 'package:mobile_pbl/screens/list_progress_agenda_screen.dart';
import 'package:mobile_pbl/screens/login_screen.dart';
import 'package:mobile_pbl/screens/profile_dosen_screen.dart';
import 'package:mobile_pbl/screens/riwayat_agenda.dart';
import 'package:mobile_pbl/screens/update_progress.dart';
import 'package:mobile_pbl/screens/dashboard_kaprodi_screen.dart';
import 'package:mobile_pbl/screens/activity_list_screen.dart';
import 'package:mobile_pbl/screens/download_document_screen.dart';
import 'package:mobile_pbl/screens/first_screen.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Informasi Manajemen SDM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const  WelcomeScreen(),
      routes: {
        '/dashboard_dosen': (context) => const DashboardDosenScreen(),
        '/edit_profile_dosen': (context) => const EditProfileDosenScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile_dosen': (context) => const ProfileDosenScreen(),
        '/agenda': (context) => const ListProgressAgenda(),
        '/update': (context) => const UpdateProgressPage(),
        '/riwayay_agenda': (context) => const RiwayatAgenda(),
        '/dashboard_kaprodi': (context) => const DashboardKaprodiScreen(),
        '/activity' : (context) => const ActivityListScreen(),
        '/first_screen': (context) => const WelcomeScreen(),
      },
    );
  }
}
