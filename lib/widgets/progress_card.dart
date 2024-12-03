import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final int progress;
  final String status;

  const ProgressCard({
    super.key,
    required this.title,
    required this.progress,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text('Progress: $progress%'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress / 100,
              color: Colors.blue,
              backgroundColor: Colors.blue[100],
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: Text(
                status,
                style: TextStyle(
                  color: status == 'Selesai' ? Colors.green : Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
