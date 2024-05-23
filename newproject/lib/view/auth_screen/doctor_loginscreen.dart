import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/mainasssets/GetPostMethod.dart';
import 'package:newproject/view/auth_screen/doctor_signupscreen.dart';
import 'package:newproject/view/doctor_dashboard_screen.dart/doctor_dashboard.dart';
import 'package:newproject/view/doctor_forgotpassword_Screen/forgotpassword_phone.dart';
import 'package:newproject/view/home_screen/doctorhome_screen.dart';
import 'package:newproject/widgets_common/applogo_widget.dart';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:newproject/widgets_common/custom_textfield.dart';
import 'package:newproject/widgets_common/our_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorLoginScreen extends StatefulWidget {
  const DoctorLoginScreen({Key? key}) : super(key: key);

  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  bool _isLoading = false;
  TextEditingController _doctorRegistrationNo2 = TextEditingController();
  TextEditingController _doctorPassword2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              applogoWidget(),
              const Text(
                "Login in to MCVG",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  customTextField(
                    hint: "Registration Hint",
                    title: "Registration",
                    controller: _doctorRegistrationNo2,
                  ),
                  customTextField(
                    hint: "Password Hint",
                    title: "Password",
                    controller: _doctorPassword2,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Make a Selection",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  "Select Options",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 28),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => DoctorForgetPasswordPhoneScreen(
                                        registrationNumber:
                                            _doctorRegistrationNo2.text,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[200],
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.phone, size: 60.0),
                                        const SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Phone",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            Text(
                                              "Reset via Phone",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Text("Forget Password"),
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      // Prepare data to send for registration
                      Map<String, String> data = {
                        "registrtion_no": _doctorRegistrationNo2.text,
                        "password": _doctorPassword2.text,
                      };

                      print(data);

                      try {
                        // Make the POST request to register the doctor
                        GetPostMethodService _getPostMethodService =
                            GetPostMethodService();
                        var response = await _getPostMethodService.postData(
                          "https://shridevisatta.com/flutter/Apis/login_doctor",
                          data,
                        );

                        // Convert response to JSON
                        String jsonString =
                            await response.stream.bytesToString();
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
                          String mobileNumber =
                              jsonResponse['data'][0]['mobile'];
                          await _saveMobileNumber(mobileNumber.toString());
                          print(mobileNumber.toString());

                          Get.off(() => DoctorDashboard(
                                registrationNumber: _doctorRegistrationNo2.text,
                              ));

                          // _doctorRegistrationNo2.clear();
                          // _doctorPassword2.clear();
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
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 40,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                          child: const Center(
                              child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        if (_isLoading)
                          const Positioned.fill(
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ourButton(
                    color: Colors.lightGreen,
                    title: "Register",
                    textColor: Colors.white,
                    onPress: () {
                      Get.to(() => const DoctorSignupScreen());
                    },
                  ).box.width(MediaQuery.of(context).size.width - 50).make(),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(MediaQuery.of(context).size.width - 70)
                  .shadowSm
                  .make(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveMobileNumber(String mobileNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobileNumber', mobileNumber);
    print(mobileNumber.toString());
  }

  Future<void> _saveRegistrationNumber(String registrationNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('registrtion_no', registrationNumber);
    print(registrationNumber);
  }
}
