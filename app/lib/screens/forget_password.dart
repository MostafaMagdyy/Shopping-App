import 'package:app/screens/verification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/widgets/text_field.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/navigation_icon.dart';
import 'package:app/screens/welcome.dart';

class ForgetPassword extends StatelessWidget {
  final String action;

  ForgetPassword({this.action = "Forget"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A2E33),
              Color(0xFF292D32),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  child: Container(color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: CustomBackNavigation(
                    destinationScreen: WelcomeScreen(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 24, bottom: 24),
                  child: Text(
                    action == 'Forget'
                        ? 'Forget\nPassword?'
                        : 'Create\nPassword',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      height: 37.5 / 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 245, 245, 245),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 56, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (action == 'Forget') ...[
                          CustomTextFormField(
                            labelText: 'Email or Mobile Number',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your mobile number';
                              }
                              return null;
                            },
                          ),
                        ] else if (action == 'Create') ...[
                          CustomTextFormField(
                            labelText: 'New Password',
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a new password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          CustomTextFormField(
                            labelText: 'Confirm Password',
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              return null;
                            },
                          ),
                        ],
                        SizedBox(height: 16), // Add some space above the button
                        Padding(
                          padding: EdgeInsets.only(top: 16, bottom: 32),
                          child: CustomButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VerificationScreen()),
                                );
                              },
                              text: 'Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
