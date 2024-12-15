import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class UploadFile extends StatefulWidget {
  final void Function(http.MultipartFile?) onFileChanged;

  const UploadFile({required this.onFileChanged, super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  String? selectedFileName; // Menyimpan nama file yang dipilih
  FilePickerResult? selectedFile; // Menyimpan file yang dipilih

  Future<void> pickFile() async {
    try {
      // Pilih file menggunakan file_picker
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'], // Format yang diizinkan
      );

      if (result != null && result.files.isNotEmpty) {
        // Ambil nama file
        setState(() {
          selectedFileName = result.files.single.name;
          selectedFile = result;
        });

        // Panggil fungsi onFileChanged yang diberikan
        // Create MultipartFile
        final filePath = result.files.single.path!;
        final multipartFile = await http.MultipartFile.fromPath(
          'file_dokumentasi', // The field name for your API
          filePath,
        );

        widget.onFileChanged(multipartFile);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error memilih file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickFile, // Fungsi untuk memilih file saat di-klik
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: selectedFileName == null
              ? const Text(
                  'Drag & drop file atau klik untuk memilih\nPDF, DOC, DOCX (Max. 5MB)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                )
              : Text(
                  'File terpilih: $selectedFileName',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
        ),
      ),
    );
  }
}
