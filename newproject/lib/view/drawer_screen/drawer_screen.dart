import 'package:flutter/material.dart';
import 'package:newproject/consts/images.dart';
import 'package:newproject/view/drawer_screen/details_screen.dart';
import 'package:newproject/view/drawer_screen/settings_screen.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String selectedButton = '';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
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
                    height: 80,
                    margin: const EdgeInsets.only(top: 24, bottom: 12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(icAppLogo),
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
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () {
              _onButtonPressed('Profile');
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(DetailsScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedButton == 'Profile' ? Colors.blue : Colors.white70,
              padding: const EdgeInsets.all(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.person, size: 24),
                SizedBox(width: 8),
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () {
              _onButtonPressed('Settings');
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedButton == 'Settings' ? Colors.blue : Colors.white70,
              padding: const EdgeInsets.all(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.settings, size: 24),
                SizedBox(width: 8),
                Text(
                  'Settings',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () {
              _onButtonPressed('Logout');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedButton == 'Logout' ? Colors.blue : Colors.white70,
              padding: const EdgeInsets.all(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.arrow_back, size: 24),
                SizedBox(width: 8),
                Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onButtonPressed(String buttonName) {
    setState(() {
      selectedButton = buttonName;
    });
  }
}
