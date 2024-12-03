import 'package:flutter/material.dart';
import '../widgets/footer.dart';
import 'edit_profile_kaprodi_screen.dart';
// import '../widgets/prevent_overflow_widget.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.black)),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/edit_profile');
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
            onPressed: () {},
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileKaprodiScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("EDIT"),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background abu-abu terang
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        'https://storage.googleapis.com/a1aa/image/QuyYyxTMeZTnE6V7DkptUvcbJN7Gv1qoNS2ytmzpWYwLod5JA.jpg',
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "Dr. John Doe, PhD",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Grid dengan lensa silindris
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3, // Proporsi kotak
                children: [
                  _buildInputField("Username", "johndoe123"),
                  _buildInputField("Program Studi", "Teknik Informatika"),
                  _buildInputField("Nama Lengkap", "John Doe"),
                  _buildInputField("Jabatan Fungsional", "Dosen"),
                  _buildInputField("NIDN", "123456789"),
                  _buildInputField("Pendidikan Terakhir", "S3 - Teknik Informatika"),
                  _buildInputField("Jenis kelamin", "Laki-laki"),
                  _buildInputField("Status Pernikahan", "Menikah"),
                  _buildInputField("Tempat, Tanggal Lahir", "Jakarta, 1 Januari 1980"),
                  _buildInputField("Status Ikatan Kerja", "Tetap"),
                  _buildInputField("Agama", "Islam"),
                  _buildInputField("Email", "johndoe@example.com"),
                  _buildInputField("Alamat", "Jl. Merdeka No. 123, Jakarta"),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Footer(),
  
    );
  }

  Widget _buildInputField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 50, maxHeight: 50),
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background abu-abu
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Text(value, style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
