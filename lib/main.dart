import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(const KApp());
}

class KApp extends StatelessWidget {
  const KApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5)),
      ),
      home: const KHomePage(),
    );
  }
}

class KHomePage extends StatefulWidget {
  const KHomePage({super.key});

  @override
  State<KHomePage> createState() => _KHomePageState();
}

class _KHomePageState extends State<KHomePage> {
  File? _pdfFile;

  Future<void> _pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _pdfFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('K', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: _pickPDF,
          ),
        ],
      ),
      body: _pdfFile != null
          ? SfPdfViewer.file(_pdfFile!)
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.picture_as_pdf, size: 80, color: Colors.blue),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _pickPDF,
                    icon: const Icon(Icons.folder_open),
                    label: const Text('Open PDF File'),
                  ),
                ],
              ),
            ),
    );
  }
}
