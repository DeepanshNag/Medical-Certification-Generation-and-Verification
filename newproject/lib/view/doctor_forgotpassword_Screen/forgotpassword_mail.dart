import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/view/doctor_forgotpassword_Screen/email_otpscreen.dart';
import 'package:newproject/widgets_common/bg_widget.dart';

class DoctorForgetPasswordMailScreen extends StatefulWidget {
  final String registrationNumber;

  const DoctorForgetPasswordMailScreen(
      {Key? key, required this.registrationNumber})
      : super(key: key);
  @override
  State<DoctorForgetPasswordMailScreen> createState() =>
      _DoctorForgetPasswordMailScreenState();
}

class _DoctorForgetPasswordMailScreenState
    extends State<DoctorForgetPasswordMailScreen> {
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/icons/bg.png'), // Replace with your image
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(54.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/icons/otpemail.png'),
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
                  'Doctor enter your email to reset your password',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  // You can use a controller to retrieve the entered email
                  // controller: _emailController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Get.to(() => const DoctorEmailOtpScreen(registrationNumber: ,));
                    Get.snackbar('Reset Link Sent',
                        'We sent an confirmaton code to reset your password.',
                        snackPosition: SnackPosition.TOP,
                        margin: const EdgeInsets.only(top: 70));
                    // Implement the logic to send a reset link to the entered email
                    // You can retrieve the entered email using _emailController.text
                    // and send a reset link
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                  ),
                  child: const Text(
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
      ),
    );
  }
}
