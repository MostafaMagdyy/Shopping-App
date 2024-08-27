import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:app/screens/welcome.dart';
import 'package:app/widgets/text_field.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/country_bottom_sheet.dart';

const TextStyle baseTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
  height: 1.33,
  color: Colors.black,
);

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedCountryCode = "+1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/auth_cover.png',
                  width: double.infinity,
                  height: 290.0,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10.0,
                  left: 10.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  WelcomeScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(-1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeIn;

                            final tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            final offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 400),
                        ),
                      );
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
                  ),
                ),
                Positioned(
                  bottom: 40.0,
                  left: 16.0,
                  child: Container(
                    height: 50.0,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Create Account\n',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              height: 28.13 / 24,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'Start shopping now',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 245, 245),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            labelText: 'First Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          CustomTextFormField(
                            labelText: 'Last Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          CustomTextFormField(
                            labelText: 'Email',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          GestureDetector(
                            onTap: () => showCountryCodeBottomSheet(
                              context,
                              _selectedCountryCode,
                              (String selectedCode) {
                                _selectedCountryCode = selectedCode;
                              },
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 14.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Text(
                                'Country',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () => showCountryCodeBottomSheet(
                                    context,
                                    _selectedCountryCode,
                                    (String selectedCode) {
                                      _selectedCountryCode = selectedCode;
                                    },
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 14.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text(
                                      _selectedCountryCode ?? '+1',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                flex: 2,
                                child: CustomTextFormField(
                                  labelText: 'Mobile Number',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your mobile number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          CustomTextFormField(
                            labelText: 'Password',
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {}
                            },
                            text: 'Sign Up',
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Already Have Account? ',
                                      style: baseTextStyle,
                                    ),
                                    TextSpan(
                                      text: 'Login',
                                      style: baseTextStyle.copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  child: Divider(
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    'OR',
                                    style: baseTextStyle,
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  child: Divider(
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/Google.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              SizedBox(width: 20.0),
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/Apple.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              SizedBox(width: 20.0),
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/Facebook.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
