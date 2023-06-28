import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final IconData myIcon;
  final String myLabelText;
  final bool toHide;

  const TextInputField(
      {super.key,
      required this.controller,
      required this.myIcon,
      required this.myLabelText,
      this.toHide = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: toHide,
      decoration: InputDecoration(
        prefixIcon: Icon(myIcon),
        labelText: myLabelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
