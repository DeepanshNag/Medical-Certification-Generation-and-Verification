import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart'; // Assuming you're using velocity_x for text styling

// Define your constants
const semibold = 'Semibold';
const lightGrey = Colors.grey;
const textfieldGrey = Colors.grey;
const redColor = Colors.red;

Widget customTextField({
  String? title,
  String? hint,
  TextEditingController? controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(Vx.blue900).fontFamily(semibold).size(18).make(),
      SizedBox(height: 5),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
        ),
      ),
      SizedBox(height: 5),
    ],
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController myController = TextEditingController();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom TextField Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: customTextField(
            title: 'Title',
            hint: 'Enter something',
            controller: myController,
          ),
        ),
      ),
    );
  }
}
