import 'package:flutter/material.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/view/drawer_screen/drawer_screen.dart';
import 'package:newproject/widgets_common/bg_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key});

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          bgWidget(), // Assuming you have a bgWidget() function
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 61, 46, 46),
                  ),
                ),
                SizedBox(height: 20),

                // Adding another text in a new line
                Text(
                  'General app and account settings',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),

                // Your existing widgets or settings
                // ...

                // Additional widgets or settings can be added here...
              ],
            ),
          ),
        ],
      ),
    );
  }
}
