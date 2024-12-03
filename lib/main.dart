import 'package:flutter/material.dart';
import 'package:mobile_pbl/screens/agenda_nonjti.dart';
import 'package:mobile_pbl/screens/dashboard_dosen_screen.dart';
import 'package:mobile_pbl/screens/edit_profile_dosen_screen.dart';
import 'package:mobile_pbl/screens/list_progress_agenda_screen.dart';
import 'package:mobile_pbl/screens/login_screen.dart';
import 'package:mobile_pbl/screens/profile_dosen_screen.dart';
import 'package:mobile_pbl/screens/riwayat_agenda.dart';
import 'package:mobile_pbl/screens/riwayat_nonjti.dart';
import 'package:mobile_pbl/screens/update_progress.dart';
import 'package:mobile_pbl/screens/dashboard_kaprodi_screen.dart';
import 'package:mobile_pbl/screens/activity_list_screen.dart';
import 'package:mobile_pbl/screens/download_document_screen.dart';

void main() async{
  runApp(MyApp());
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
      home: LoginScreen(),
      routes: {
        '/dashboard_dosen': (context) => DashboardDosenScreen(),
        '/edit_profile_dosen': (context) => EditProfileDosenScreen(),
        '/login': (context) => LoginScreen(),
        '/profile_dosen': (context) => ProfileDosenScreen(),
        '/agenda': (context) => ListProgressAgenda(),
        '/update': (context) => UpdateProgressPage(),
        '/nonjti_agenda': (context) => AgendaNonjti(),
        '/riwatat_nonjti': (context) => RiwayatNonjti(),
        '/riwayay_agenda': (context) => RiwayatAgenda(),
        '/dashboard_kaprodi': (context) => DashboardKaprodiScreen(),
        '/activity' : (context) => ActivityListScreen(),
        '/download_document': (context) => DownloadDocumentsScreen(),
      },
    );
  }
}
