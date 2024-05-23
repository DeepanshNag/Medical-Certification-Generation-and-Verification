import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/view/patient_dashboard_screen/patient_dashboard.dart';
import 'package:newproject/view/drawer_screen/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Vx.blue100,
      drawer: const MainDrawer(),
      body: const PatientDashboard(),
    );
  }
}
