import 'package:flutter/material.dart';

class CustomBackNavigation extends StatelessWidget {
  const CustomBackNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, true);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 14.0,
        ),
      ),
    );
  }
}
