


import 'package:flutter/material.dart';

class kTextField extends StatelessWidget {
  TextEditingController controller;
  String label;
  String hintText;
  TextInputType? keyBoardType;
  kTextField({
    required this.controller,
    required this.label,
    required this.hintText,
    this.keyBoardType=TextInputType.text
});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(10)
        ),
        // floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
