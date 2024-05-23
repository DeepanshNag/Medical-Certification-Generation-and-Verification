import 'package:get/get.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/view/auth_screen/doctor_loginscreen.dart';
import 'package:newproject/view/auth_screen/patient_loginscreen.dart';
import 'package:newproject/view/guest_dashboard_screen/guest_dashboard.dart';
import 'package:newproject/widgets_common/bg_widget.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //const SizedBox(height: 0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                        'assets/icons/app_logo.png'), // Replace with your image path
                    height: 180,
                    width: 180,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              "Welcome to the MCVG"
                  .text
                  .fontFamily(bold)
                  .blue900
                  .size(24)
                  .make(),
              const SizedBox(height: 20),
              10.heightBox,
              // First row of buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder(
                    duration: const Duration(seconds: 1),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, value * 20),
                        child: RoundedButton(
                          label: 'Patient',
                          icon: Icons.person,
                          onPressed: () {
                            Get.to(() => const PatientLoginScreen());
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  TweenAnimationBuilder(
                    duration: const Duration(seconds: 1),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, value * 20),
                        child: RoundedButton(
                          label: 'Doctor',
                          icon: Icons.local_hospital,
                          onPressed: () {
                            Get.to(() => const DoctorLoginScreen());
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Second row with the new button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder(
                    duration: const Duration(seconds: 1),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, value * 20),
                        child: RoundedButton(
                          label: 'Guest',
                          icon: Icons.person,
                          onPressed: () {
                            Get.to(() => GuestDashboard());
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final double width;

  const RoundedButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.width = 160, // Default width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 34),
        width: width,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
