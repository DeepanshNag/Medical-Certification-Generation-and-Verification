import 'package:flutter/material.dart';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCertificate extends StatefulWidget {
  const VerifyCertificate({Key? key});

  @override
  _VerifyCertificateState createState() => _VerifyCertificateState();
}

class _VerifyCertificateState extends State<VerifyCertificate>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

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
                            // Handle verification button press
                          },
                          child: const Text('Verify Certificate'),
                        ),
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
}
