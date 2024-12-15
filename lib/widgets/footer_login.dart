import 'package:flutter/material.dart';

class FooterLogin extends StatelessWidget {
  const FooterLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF3366CC),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row(
          //   children: [
          //     Image.network(
          //       'https://pbs.twimg.com/profile_images/1628751671420669952/WbdE8w2x_400x400.jpg',
          //       height: 25,
          //     ),
          //     const SizedBox(width: 20),
          //     const Expanded(
          //       child: Text(
          //         'BLU POLITEKNIK NEGERI MALANG\n'
          //         '- Soekarno Hatta Street No.9 Malang 65141\n'
          //         'Jatimulyo, Kec. Lowokwaru, Malang,\n'
          //         'East Java - Indonesia\n'
          //         '- PMDN',
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 10),
          const Text(
            'Kontak',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.facebook, color: Colors.white),
              SizedBox(width: 10),
              Icon(Icons.email, color: Colors.white),
              SizedBox(width: 10),
              Icon(Icons.youtube_searched_for, color: Colors.white),
            ],
          ),
          const SizedBox(height: 7),
          const Text(
            '2024 © Sistem Informasi Manajemen SDM',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
