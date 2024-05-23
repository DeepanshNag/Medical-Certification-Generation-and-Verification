import 'package:flutter/material.dart';
import 'package:newproject/widgets_common/bg_widget.dart';

class Doctor extends StatefulWidget {
  const Doctor({super.key});

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/app_logo.png',
              height: 50,
              width: 20,
            ),
            const SizedBox(
              width: 8,
            ),
            const Text('MCVG'),
          ],
        ),
      ),
      body: Stack(
        children: [bgWidget()],
      ),
    );
  }
}
