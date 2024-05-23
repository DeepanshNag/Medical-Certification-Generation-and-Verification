import 'dart:convert'; // Add this import for using json decoding
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:newproject/consts/styles.dart';
import 'package:newproject/mainasssets/GetPostMethod.dart';
import 'package:newproject/view/doctor_forgotpassword_Screen/phone_otp_screen.dart';
import 'package:newproject/view/patient_dashboard_screen/patient_dashboard.dart';
import 'package:newproject/view/patient_forgotpassword_Screen/phoneotp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Import the service for making POST requests

class ForgetPasswordPhoneScreen extends StatefulWidget {
  @override
  _ForgetPasswordPhoneScreenState createState() =>
      _ForgetPasswordPhoneScreenState();
}

class _ForgetPasswordPhoneScreenState extends State<ForgetPasswordPhoneScreen> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _pateintRegistrationNo2 =
      TextEditingController(); // Add controller for registration number
  TextEditingController _pateintPassword2 =
      TextEditingController(); // Add controller for password
  bool _isLoading = false; // Add state variable for loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icons/bg.png'), // Replace with your image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(54.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/icons/otpphone.png'),
                height: 150,
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Forget Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter your phone number to reset your password',
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType:
                    TextInputType.phone, // Change keyboardType to phone
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  // Prepare data to send for password reset
                  Map<String, String> data = {
                    "mobile": _phone.text,
                  };
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('mobile', _phone.text);

                  print(data);

                  try {
                    // Make the POST request to reset password
                    GetPostMethodService _getPostMethodService =
                        GetPostMethodService();
                    var response = await _getPostMethodService.postData(
                      "https://shridevisatta.com/flutter/Apis/forget_password",
                      data,
                    );

                    // Convert response to JSON
                    String jsonString = await response.stream.bytesToString();
                    Map jsonResponse = json.decode(jsonString);
                    print(jsonResponse);

                    // Handle the response
                    if (jsonResponse["res"] == 'success') {
                      // Password reset successful
                      Fluttertoast.showToast(
                        msg: jsonResponse['msg'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 4,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      Get.off(() => OtpPhoneScreen());
                    } else {
                      // Password reset failed
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
                    // Error occurred during password reset
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
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: Text(
                  'Send Reset Link',
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
    );
  }
}
