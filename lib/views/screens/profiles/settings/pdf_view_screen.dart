

import 'package:careshiftapp/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PdfViewScreen extends StatefulWidget {
  final String pdfUrl;

  PdfViewScreen({required this.pdfUrl});

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String? localFilePath;

  @override
  void initState() {
    super.initState();
    downloadAndSavePdf(widget.pdfUrl);
  }

  // Function to download the PDF file from the server and save it locally
  Future<void> downloadAndSavePdf(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Get the temporary directory to store the file
        final directory = await getTemporaryDirectory();
        final filePath = "${directory.path}/temp_pdf.pdf";

        // Save the PDF file to the local storage
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          localFilePath = filePath;
        });
      } else {
        throw Exception("Failed to load PDF");
      }
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(localFilePath);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('View PDF'),
        ),
        body: localFilePath == null
            ? Center(child: CustomLoader())
            : PDFView(
          filePath: localFilePath!,
        ),
      ),
    );
  }
}
