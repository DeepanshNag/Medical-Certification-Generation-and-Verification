import 'package:flutter/material.dart';
import 'package:newproject/consts/styles.dart';
import 'package:velocity_x/velocity_x.dart'; // Assuming you're using velocity_x for text styling

Widget ourButton({
  required VoidCallback onPress, // Marking onPress as required
  Color? color,
  Color? textColor,
  String? title,
  bool isLoading = false,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: isLoading ? null : onPress,
    child: isLoading
        ? CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(textColor ?? Colors.white),
          )
        : title!.text.color(textColor).fontFamily(bold).make(),
  );
}
