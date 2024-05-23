import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/view/patient_forgotpassword_Screen/emailotp_screen.dart';
import 'package:newproject/widgets_common/bg_widget.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

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
                  'Enter your email to reset your password',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const OtpScreen());
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

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
          // Define your theme here
          // Example: primaryColor, accentColor, fontFamily, etc.
          ),
      home: const ForgetPasswordMailScreen(),
    ),
  );
}
