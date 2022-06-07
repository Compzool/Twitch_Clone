import 'package:flutter/material.dart';
import 'package:twitch_clone/utils/colors.dart';
import 'package:twitch_clone/utils/hexcolor.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool isObscure;
  final IconData icon;
  final Function(String)? onTap;
   CustomTextField(
      {Key? key,
      required this.controller,
      required this.text,
      required this.icon,
      this.onTap,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onFieldSubmitted: onTap,
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: buttonColor,
            ),
            labelText: text,
            labelStyle: TextStyle(
              color: Colors.deepPurpleAccent,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor('651FFF')),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: secondaryBackgroundColor,
                ),
                borderRadius: BorderRadius.circular(10))));
  }
}
