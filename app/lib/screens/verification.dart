import 'dart:async';
import 'package:app/screens/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/navigation_icon.dart';
import 'package:app/screens/welcome.dart';

const TextStyle baseTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  height: 1.33,
  color: Colors.black,
);

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int _timeLeft = 60;
  late Timer _timer;
  List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  String get timerText {
    if (_timeLeft > 0) {
      return 'Resend code in 00:${_timeLeft.toString().padLeft(2, '0')}';
    } else {
      return 'Resend code';
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                child: Container(color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Row(
                  children: [
                    CustomBackNavigation(),
                    SizedBox(width: 16),
                    Text(
                      'Verification',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 18.75 / 16,
                        letterSpacing: 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(245, 245, 245, 245),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/verification.png', height: 120),
                          SizedBox(height: 20),
                          Text(
                            'Enter 4 Digits code has been sent to\n +961518745363',
                            style: baseTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              4,
                              (index) => Container(
                                width: 46,
                                height: 46,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: TextField(
                                  controller: controllers[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.length == 1 && index < 3) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: _timeLeft == 0
                                    ? () {
                                        setState(() {
                                          _timeLeft = 59;
                                        });
                                        startTimer();
                                      }
                                    : null,
                                child: Text(
                                  timerText,
                                  style: baseTextStyle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 32),
                          CustomButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassword(
                                          action: "Create",
                                        )),
                              );
                            },
                            text: 'Submit',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
