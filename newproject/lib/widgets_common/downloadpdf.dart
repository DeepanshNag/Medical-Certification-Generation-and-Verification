import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';

void main() {

  runApp(const pdfDownload());
  WidgetsFlutterBinding.ensureInitialized();
}

class pdfDownload extends StatefulWidget {
  const pdfDownload({super.key});

  @override
  State<pdfDownload> createState() => _pdfDownloadState();
}

class _pdfDownloadState extends State<pdfDownload> {

  final _flutterMediaDownloaderPlugin = MediaDownload();

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(onPressed: () async {
            _flutterMediaDownloaderPlugin.downloadMedia(context,'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf');
          }, child: const Text('Media Download')),
        ),
      ),
    );
  }
}