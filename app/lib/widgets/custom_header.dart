import 'package:app/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/widgets/navigation_icon.dart';

class CustomHeader extends StatelessWidget {
  final String headerText; // Text to display as the header
  final Widget? rightWidget; // Optional widget to display on the right side

  const CustomHeader({
    Key? key,
    required this.headerText,
    this.rightWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 4, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBackNavigation(destinationScreen: WelcomeScreen()),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              headerText,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 18.75 / 16,
                letterSpacing: 0.05,
                color: Colors.white,
              ),
            ),
          ),
          if (rightWidget != null) rightWidget!,
        ],
      ),
    );
  }
}
