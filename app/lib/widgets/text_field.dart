import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(16.0), // Set border radius
      ),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none, // No border
          // Add padding from top and left
          contentPadding: EdgeInsets.only(top: 16.0, left: 14.0),
        ),
        validator: validator,
      ),
    );
  }
}
  