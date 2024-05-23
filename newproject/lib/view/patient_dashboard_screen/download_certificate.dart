import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:newproject/mainasssets/GetPostMethod.dart';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:newproject/widgets_common/downloadpdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const pdfDownload());
  WidgetsFlutterBinding.ensureInitialized();
}

class DownloadCertificateScreen extends StatefulWidget {
  const DownloadCertificateScreen({Key? key});

  @override
  _DownloadCertificateScreenState createState() =>
      _DownloadCertificateScreenState();
}

class _DownloadCertificateScreenState extends State<DownloadCertificateScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  TextEditingController _pincode = TextEditingController();

  bool _isLoading = false;
  final _flutterMediaDownloaderPlugin = MediaDownload();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Trigger the animation when the widget is first built
    _animationController.forward();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _fadeInAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeInAnimation.value,
            child: Stack(
              children: [
                // Background Widget
                bgWidget(),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Enter the Certificate ID number:',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        PinCodeTextField(
                          controller: _pincode,
                          appContext: context,
                          length: 5,
                          onChanged: (value) {
                            // Handle OTP changes
                          },
                          onCompleted: (value) {
                            // Handle completed OTP
                          },
                          textStyle: const TextStyle(fontSize: 20),
                          cursorColor: Colors.black,
                          cursorWidth: 2,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            inactiveColor: Colors.grey,
                            activeColor: Colors.black,
                            selectedColor: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              _download();
                              // Add your download logic here
                            },
                            child: GestureDetector(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Text(
                                      'Download Certificate'), // Your text widget
                                  _isLoading // Conditionally display CircularProgressIndicator based on downloading state
                                      ? CircularProgressIndicator()
                                      : SizedBox(), // Placeholder for CircularProgressIndicator
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _download() async {
    setState(() {
      _isLoading = true;
    });

    // Prepare data to send for certificate download
    Map<String, String> data = {
      "certificate_number": _pincode.text,
    };

    try {
      // Make the POST request to download the certificate
      GetPostMethodService _getPostMethodService = GetPostMethodService();
      var response = await _getPostMethodService.postData(
        "https://shridevisatta.com/flutter/Apis/certificate",
        data,
      );

      // Convert response to JSON
      String jsonString = await response.stream.bytesToString();
      Map jsonResponse = json.decode(jsonString);

      // Handle the response
      if (jsonResponse["res"] == "success") {
        // Certificate download successful
        // Open the URL
        launch(jsonResponse['url']);

        // Show success message
        Fluttertoast.showToast(
          msg: jsonResponse['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        // Certificate download failed
        // Show error message
        Fluttertoast.showToast(
          msg: jsonResponse['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      // Error occurred during certificate download
      // Show error message
      Fluttertoast.showToast(
        msg: "Error occurred: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    // Reset loading state
    setState(() {
      _isLoading = false;
    });
  }
}
