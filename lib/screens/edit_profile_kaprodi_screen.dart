import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/footer.dart';
// import '../widgets/prevent_overflow_widget.dart';


class EditProfileKaprodiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(color: Colors.black)),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Kembali ke halaman Profile
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
              // Aksi untuk logout (opsional)
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Foto Profil dan Pilih Foto
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      "https://storage.googleapis.com/a1aa/image/Xp7uS953nELxJdl3wVHlgjm8M3Fufb7dJv6WTbIqMf97vAzTA.jpg",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Aksi untuk memilih foto
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Pilih Foto"),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Format: JPG, JPEG, PNG (Max. 2MB)",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Formulir Edit
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3, // Proporsi kotak
                children: [
                  CustomTextField(label: "Username"),
                  CustomTextField(label: "Program Studi"),
                  CustomTextField(label: "Nama Lengkap"),
                  CustomTextField(label: "Jabatan Fungsional"),
                  CustomTextField(label: "NIDN"),
                  CustomTextField(label: "Pendidikan Terakhir"),
                  CustomTextField(label: "Jenis kelamin"),
                  CustomTextField(label: "Status Pernikahan"),
                  CustomTextField(label: "Tempat, Tanggal Lahir"),
                  CustomTextField(label: "Asal Perguruan Tinggi"),
                  CustomTextField(label: "Gelar Depan"),
                  CustomTextField(label: "Gelar Belakang"),
                  CustomTextField(label: "Email"),
                ],
              ),
              const SizedBox(height: 20),

              // Ganti Password
              const Text(
                "Ganti Password",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomTextField(label: "Password saat ini", isPassword: true),
              Row(
                children: [
                  Expanded(child: CustomTextField(label: "Password baru", isPassword: true)),
                  const SizedBox(width: 16),
                  Expanded(child: CustomTextField(label: "Konfirmasi Password", isPassword: true)),
                ],
              ),
              const SizedBox(height: 20),

              // Tombol Simpan dan Hapus
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/profile'); // Kembali ke halaman ProfileScreen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("SIMPAN"),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/profile'); // Kembali ke halaman ProfileScreen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("HAPUS"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

        // Footer Navigasi Tetap
        bottomNavigationBar: Footer(),

    );
  }
}
