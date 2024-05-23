import 'package:flutter/material.dart';
import 'package:newproject/consts/images.dart';
import 'package:newproject/view/drawer_screen/drawer_screen.dart';
import 'package:newproject/widgets_common/bg_widget.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  static const String routeName = '/details'; // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('My Profile'),
            ],
          ),
        ),
        drawer: const MainDrawer(),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.blue,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 180,
                      margin: const EdgeInsets.only(top: 24, bottom: 12),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(icAdd),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Medical Certificate',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'admin@gmail.com',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
