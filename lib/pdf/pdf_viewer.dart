import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowCertificateScreen extends StatefulWidget {
  final String? path;
  const ShowCertificateScreen({Key? key, this.path}) : super(key: key);

  @override
  _ShowCertificateScreenState createState() => _ShowCertificateScreenState();
}

class _ShowCertificateScreenState extends State<ShowCertificateScreen>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final file = File(widget.path!);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Certificate"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              await Share.shareFiles(
                [widget.path!],
                text: "Made in PDF with Abby",
              );
            },
          ),
        ],
      ),
      body: SfPdfViewer.file(file),
    );
  }
}
