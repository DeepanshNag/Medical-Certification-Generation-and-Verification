import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/mainasssets/GetPostMethod.dart';
import 'package:newproject/view/auth_screen/patient_loginscreen.dart';
import 'package:newproject/widgets_common/applogo_widget.dart';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:newproject/widgets_common/custom_textfield.dart';
import 'package:newproject/widgets_common/our_button.dart';

class PatientSignupScreen extends StatefulWidget {
  const PatientSignupScreen({super.key});

  @override
  State<PatientSignupScreen> createState() => _PatientSignupScreenState();
}

class _PatientSignupScreenState extends State<PatientSignupScreen> {
  bool? isCheck = false;
  bool _isLoading = false;

  TextEditingController _pateintName = TextEditingController();
  TextEditingController _pateintMobile = TextEditingController();
  TextEditingController _pateintPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                "Jion the $appname".text.fontFamily(bold).black.size(18).make(),
                15.heightBox,
                Column(
                  children: [
                    customTextField(
                        hint: nameHint, title: name, controller: _pateintName),
                    customTextField(
                        hint: numberHint,
                        title: number,
                        controller: _pateintMobile),
                    customTextField(
                        hint: passwordHint,
                        title: password,
                        controller: _pateintPassword),
                    customTextField(hint: passwordHint, title: retypePassword),
                    Row(
                      children: [
                        Checkbox(
                            value: isCheck,
                            activeColor: Colors.red,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            }),
                        10.heightBox,
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: termAndcondition,
                                  style: const TextStyle(
                                    fontFamily: regular,
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Navigate to the Terms and Conditions page
                                      Get.to(() => TermsAndConditionsPage());
                                    },
                                ),
                                const TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: privacyPolicy,
                                  style: const TextStyle(
                                    fontFamily: regular,
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Navigate to the Privacy Policy page
                                      Get.to(() => PrivacyPolicyPage());
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    5.heightBox,
                    ourButton(
                        color: isCheck == true ? Colors.blue : Colors.grey,
                        title: signup,
                        textColor: whiteColor,
                        onPress: () async {
                          Get.to(() => const PatientLoginScreen());

                          try {
                            setState(() {
                              // _isLoading = true;
                            });

                            Map<String, String> data = {
                              "name": _pateintName.text,
                              "mobile": _pateintMobile.text,
                              "password": _pateintPassword.text
                            };
                            print(data);
                            GetPostMethodService _getPostMethodService =
                                GetPostMethodService();

                            var response = await _getPostMethodService.postData(
                                "https://shridevisatta.com/flutter/Apis/patient_registration",
                                data);

                            String jsonString =
                                await response.stream.bytesToString();
                            Map jsonResponse = json.decode(jsonString);
                            print(jsonResponse);

                            if (jsonResponse["res"] == 'success') {
                              Fluttertoast.showToast(
                                msg: jsonResponse['msg'],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 4,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              setState(() {
                                // _isLoading = false;
                              });
                            } else {
                              Fluttertoast.showToast(
                                msg: jsonResponse['msg'],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 4,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                              Get.off(() => PatientLoginScreen());
                            }
                          } catch (e) {
                            setState(() {
                              // _isLoading = false;
                            });
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
                        }).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                        text: alreadyHaveAccount,
                        style: TextStyle(fontFamily: bold, color: fontGrey),
                      ),
                      TextSpan(
                        text: login,
                        style: TextStyle(fontFamily: bold, color: Colors.red),
                      )
                    ])).onTap(() {
                      Get.back();
                    }),
                  ],
                )
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
}

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Terms and Conditions"),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text("Your Terms and Conditions Page Content Here"),
        ),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Privacy and Policy"),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text("Privacy and Policy Content Here"),
        ),
      ),
    );
  }
}
