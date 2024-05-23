import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/consts/lists.dart';
import 'package:newproject/mainasssets/GetPostMethod.dart';

import 'package:newproject/view/auth_screen/patient_signupscreen.dart';
import 'package:newproject/view/patient_dashboard_screen/patient_dashboard.dart';
import 'package:newproject/view/patient_forgotpassword_Screen/forgetpasswordmail_screen.dart';
import 'package:newproject/view/patient_forgotpassword_Screen/forgotpasswordphone_screen.dart';
import 'package:newproject/view/home_screen/home_screen.dart';

import 'package:newproject/widgets_common/applogo_widget.dart';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:newproject/widgets_common/custom_textfield.dart';
import 'package:newproject/widgets_common/our_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientLoginScreen extends StatefulWidget {
  const PatientLoginScreen({super.key});

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  bool _isLoading = false;

  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                "Login in to $appname"
                    .text
                    .fontFamily(bold)
                    .blue900
                    .size(18)
                    .make(),
                15.heightBox,
                Column(children: [
                  customTextField(
                      hint: numberHint, title: number, controller: _name),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      controller: _password),
                  // Inside your Forget Password section
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
                                  makeselection,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  selectoptions,
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 20.0),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => ForgetPasswordPhoneScreen());
                                    // Handle phone reset action
                                    // Add your logic here
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: fontGrey2,
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
                                              phone,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            Text(
                                              resetviaphone,
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
                      child: forgetPass.text.make(),
                    ),
                  ),

                  5.heightBox,

                  ourButton(
                    color: Colors.blue,
                    title: "Login",
                    textColor: Colors.white,
                    onPress: () async {
                      // Set loading state
                      setState(() {
                        _isLoading = true;
                      });

                      // Prepare data to send for registration
                      Map<String, String> data = {
                        "mobile": _name.text,
                        "password": _password.text,
                      };

                      print(data);

                      try {
                        // Make the POST request to register the doctor
                        GetPostMethodService _getPostMethodService =
                            GetPostMethodService();
                        var response = await _getPostMethodService.postData(
                          "https://shridevisatta.com/flutter/Apis/patient_login",
                          data,
                        );

                        // Convert response to JSON
                        String jsonString =
                            await response.stream.bytesToString();
                        Map jsonResponse = json.decode(jsonString);
                        print(jsonResponse);

                        // Handle the response
                        if (jsonResponse["res"] == 'success') {
                          SharedPreferences prefs2 =
                              await SharedPreferences.getInstance();
                          await prefs2.setString('mobile', _name.text);
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

                          Get.off(() => PatientDashboard());
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
                  ).box.width(MediaQuery.of(context).size.width - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(
                      color: lightgolden,
                      title: signup,
                      textColor: Colors.black,
                      onPress: () {
                        Get.to(() => const PatientSignupScreen());
                      }).box.width(context.screenWidth - 50).make(),
                ])
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ]),
            )));
  }

  Future<void> _saveMobileNumber(String mobileNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobileNumber', mobileNumber);
    print(mobileNumber.toString());
  }
}
