import 'package:flutter/material.dart';
import 'package:twitch_clone/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback pressed;
  CustomButton({Key? key, required this.text, required this.pressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
          primary: buttonColor, minimumSize: Size(double.infinity, 40)),
    );
  }
}
