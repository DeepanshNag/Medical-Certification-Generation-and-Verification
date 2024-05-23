import 'package:flutter/material.dart';
import 'package:newproject/view/drawer_screen/drawer_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  static const String routeName = '/details'; // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      drawer: MainDrawer(),
      body: const Center(
        child: Text('This is the details screen.'),
      ),
    );
  }
}
