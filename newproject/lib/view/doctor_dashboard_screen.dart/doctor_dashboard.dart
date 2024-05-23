import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/view/doctor_dashboard_screen.dart/patient_certificate.dart';
import 'package:newproject/view/doctor_dashboard_screen.dart/patient_detail.dart';
import 'package:newproject/widgets_common/bg_widget.dart';

class DoctorDashboard extends StatefulWidget {
  final String registrationNumber;

  const DoctorDashboard({Key? key, required this.registrationNumber})
      : super(key: key);

  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard>
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
        padding: const EdgeInsets.all(11),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
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
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          image: AssetImage('assets/icons/wallpaper.jpg'),
                          height: 210,
                          width: 350,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Doctor Dashboard',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
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
                                'Medical Certificate',
                                'assets/icons/medic.png',
                                Colors.white70,
                                () {
                                  Get.to(() => PatientsForm(
                                        registrationNumber:
                                            widget.registrationNumber,
                                      ));
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
                                "Patient's Details",
                                'assets/icons/medic.png',
                                Colors.white70,
                                () {
                                  Get.to(() => PatientDetailsScreen());
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
