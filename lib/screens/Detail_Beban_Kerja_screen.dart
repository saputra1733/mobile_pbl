import 'package:flutter/material.dart';

class DetailBebanKerjaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POLINEMA'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('PROFILE', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('LOGOUT', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Detail Beban Kerja',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: {
                  0: FixedColumnWidth(40),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(100),
                  3: FlexColumnWidth(),
                  4: FixedColumnWidth(120),
                  5: FixedColumnWidth(80),
                  6: FixedColumnWidth(80),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    children: [
                      _buildTableCell('No.', isHeader: true),
                      _buildTableCell('Nama Kegiatan', isHeader: true),
                      _buildTableCell('Tanggal', isHeader: true),
                      _buildTableCell('PIC', isHeader: true),
                      _buildTableCell('Status', isHeader: true),
                      _buildTableCell('Dokumen', isHeader: true),
                      _buildTableCell('Aksi', isHeader: true),
                    ],
                  ),
                  _buildTableRow(1, 'Evaluasi Kurikulum', '13-05-2024', 'Dr. Kusuma', 'Sedang berlangsung', true),
                  _buildTableRow(2, 'Workshop AI', '20-12-2024', 'Dr. Prihandi', 'Selesai', true),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.tasks),
            label: 'Detail Beban Kerja',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.fileDownload),
            label: 'Unduh Dokumen',
          ),
        ],
        onTap: (index) {},
      ),
    );
  }

  TableRow _buildTableRow(int no, String nama, String tanggal, String pic, String status, bool isDownloadable) {
    return TableRow(
      children: [
        _buildTableCell(no.toString()),
        _buildTableCell(nama),
        _buildTableCell(tanggal),
        _buildTableCell(pic),
        _buildTableCell(status),
        _buildTableCell(
          isDownloadable
              ? IconButton(
                  icon: Icon(FontAwesomeIcons.download),
                  onPressed: () {},
                )
              : SizedBox(),
        ),
        _buildTableCell(
          IconButton(
            icon: Icon(FontAwesomeIcons.chartBar),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildTableCell(String content, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTableCell(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: child),
    );
  }
}