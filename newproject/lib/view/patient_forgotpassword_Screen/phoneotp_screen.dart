import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/mainasssets/GetPostMethod.dart';
import 'package:newproject/view/doctor_forgotpassword_Screen/doctor_resetpassword.dart';
import 'package:newproject/view/patient_forgotpassword_Screen/patientresetPassword_screen.dart';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPhoneScreen extends StatelessWidget {
  TextEditingController _otp = TextEditingController();

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
                          'assets/icons/security.png'), // Replace with your image path
                      height: 180,
                      width: 180,
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                const Text(
                  'OTP Verification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter the OTP sent to your mobile number ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                buildOtpTextField(),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
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

                    // Prepare data to send for OTP verification
                    Map<String, String> data = {
                      "mobile": mobile,
                      "otp": _otp.text,
                    };
                    print(data);

                    // Make the POST request to verify OTP
                    GetPostMethodService _getPostMethodService =
                        GetPostMethodService();
                    var response = await _getPostMethodService.postData(
                      "https://shridevisatta.com/flutter/Apis/verify_otp",
                      data,
                    );
                    print(data);

                    // Convert response to JSON
                    String jsonString = await response.stream.bytesToString();
                    Map jsonResponse = json.decode(jsonString);
                    print(jsonResponse);

                    // Handle the response
                    if (jsonResponse["res"] == 'success') {
                      // OTP verification successful
                      Fluttertoast.showToast(
                        msg: jsonResponse['msg'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 4,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      Get.off(() => ResetPasswordScreen());
                    } else {
                      // OTP verification failed
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
                  },
                  child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: Center(child: Text('Verify OTP'))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOtpTextField() {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: _otp,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintText: '•••••',
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
        maxLength: 6,
        onChanged: (value) {
          // Handle OTP changes if needed
        },
      ),
    );
  }
}
