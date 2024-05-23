import 'package:get/get.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/view/home_screen/doctorhome_screen.dart';
import 'package:newproject/view/patient_dashboard_screen/certificateverify_screen.dart';
import 'package:newproject/view/patient_dashboard_screen/doctor_screen.dart';
import 'package:newproject/view/patient_dashboard_screen/download_certificate.dart';
import 'package:newproject/widgets_common/bg_widget.dart';

class GuestDashboard extends StatefulWidget {
  const GuestDashboard({Key? key}) : super(key: key);

  @override
  _GuestDashboardState createState() => _GuestDashboardState();
}

class _GuestDashboardState extends State<GuestDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  ElevatedButton _buildStyledButton(
    String title,
    String imagePath,
    Color backgroundColor,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 110,
            width: 110,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
                fontSize: 15, fontFamily: bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          bgWidget(),
          SingleChildScrollView(
            child: Center(
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/icons/otpemail.png'),
                          height: 180,
                          width: 280,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 1),
                              end: const Offset(0, 0),
                            ).animate(_animation),
                            child: AnimatedOpacity(
                              opacity: 1,
                              duration: const Duration(seconds: 1),
                              child: _buildStyledButton(
                                'Doctor',
                                'assets/icons/doctor.png',
                                Colors.white70,
                                () {
                                  Get.to(() => const ViewedDoctorScreen());
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 1),
                              end: const Offset(0, 0),
                            ).animate(_animation),
                            child: AnimatedOpacity(
                              opacity: 1,
                              duration: const Duration(seconds: 1),
                              child: _buildStyledButton(
                                "Certificate",
                                'assets/icons/verify.png',
                                Colors.white70,
                                () {
                                  Get.to(
                                      () => const DownloadCertificateScreen());
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: const Offset(0, 0),
                        ).animate(_animation),
                        child: AnimatedOpacity(
                          opacity: 1,
                          duration: const Duration(seconds: 1),
                          child: _buildStyledButton(
                            "Logout",
                            'assets/icons/logout.png',
                            Colors.white70,
                            () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PatientDetailsForm extends StatelessWidget {
  const PatientDetailsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details Form'),
      ),
      body: const Center(
        child: Text('Patient Details Form Content'),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: GuestDashboard(),
    ),
  );
}
