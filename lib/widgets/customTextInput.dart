import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Function validator;

  CustomTextFormField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      obscureText: obscureText,
      validator: (value) => validator(value),
    );
  }
}
