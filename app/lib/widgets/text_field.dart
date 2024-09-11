import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool showBorderAndPlaceholder;
  const CustomTextFormField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.controller,
    this.showBorderAndPlaceholder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: showBorderAndPlaceholder
            ? null
            : Border.all(color: Color(0xFFCCCCCC), width: 1),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: showBorderAndPlaceholder ? labelText : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 16.0, left: 14.0),
        ),
        validator: validator,
      ),
    );
  }
}
