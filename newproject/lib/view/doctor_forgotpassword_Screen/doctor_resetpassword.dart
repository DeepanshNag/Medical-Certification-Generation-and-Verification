import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:newproject/mainasssets/GetPostMethod.dart';
import 'package:newproject/view/doctor_dashboard_screen.dart/doctor_dashboard.dart';
import 'package:newproject/view/home_screen/doctorhome_screen.dart';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorResetPasswordScreen extends StatefulWidget {
  final String registrationNumber;

  DoctorResetPasswordScreen({Key? key, required this.registrationNumber})
      : super(key: key);

  @override
  State<DoctorResetPasswordScreen> createState() =>
      _DoctorResetPasswordScreenState();
}

class _DoctorResetPasswordScreenState extends State<DoctorResetPasswordScreen> {
  TextEditingController _resetpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                          'assets/icons/resetpassword.png'), // Replace with your image path
                      height: 180,
                      width: 180,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Create A Strong Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Doctor your password must be at least 6 characters and should include a combination of numbers, letters and Special characters (!@#%)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                buildPasswordTextField(),
                const SizedBox(height: 20),
                buildAgainPasswordTextField(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Get.to(() =>  DoctorHomeScreen());

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? mobile = prefs.getString('mobile');

                    if (mobile == null || mobile.isEmpty) {
                      // Handle if mobile number is not available
                      Fluttertoast.showToast(
                        msg: "Mobile number not found",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 4,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      return;
                    }

                    // Prepare data to send for registration
                    Map<String, String> data = {
                      "mobile": mobile,
                      "password": _resetpassword.text,
                    };

                    print(data);

                    try {
                      // Make the POST request to register the doctor
                      GetPostMethodService _getPostMethodService =
                          GetPostMethodService();
                      var response = await _getPostMethodService.postData(
                        "https://shridevisatta.com/flutter/Apis/update_password",
                        data,
                      );
                      print(data);

                      // Convert response to JSON
                      String jsonString = await response.stream.bytesToString();
                      Map jsonResponse = json.decode(jsonString);
                      print(jsonResponse);

                      // Handle the response
                      if (jsonResponse["res"] == 'success') {
                        // Registration successful
                        Fluttertoast.showToast(
                          msg: jsonResponse['msg'],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 4,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorDashboard(
                                    registrationNumber:
                                        widget.registrationNumber,
                                  )),
                        );
                      } else {
                        // Registration failed
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
                      // Error occurred during registration
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                  ),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordTextField() {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: _resetpassword,
        obscureText: true,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'New password',
          hintStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black87),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black87),
          ),
        ),
        onChanged: (value) {
          // Handle password changes if needed
        },
      ),
    );
  }

  Widget buildAgainPasswordTextField() {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: _resetpassword,
        obscureText: true,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'New password, again',
          hintStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black87),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black87),
          ),
        ),
        onChanged: (value) {
          // Handle password changes if needed
        },
      ),
    );
  }
}
