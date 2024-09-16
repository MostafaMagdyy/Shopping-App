import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password Changed Successfully!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C2C2C),
              Color(0xFF292D32),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                child: CustomHeader(
                  headerText: '',
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 230, 230, 230),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Old Password',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            CustomTextFormField(
                              labelText: 'Old Password',
                              obscureText: true,
                              controller: _oldPasswordController,
                              showBorderAndPlaceholder: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your old password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'New Password',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            CustomTextFormField(
                              labelText: 'New Password',
                              obscureText: true,
                              controller: _newPasswordController,
                              showBorderAndPlaceholder: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your new password';
                                }
                                if (value.length < 6) {
                                  return 'Password should be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Confirm Password',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            CustomTextFormField(
                              labelText: 'Confirm Password',
                              obscureText: true,
                              controller: _confirmPasswordController,
                              showBorderAndPlaceholder: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your new password';
                                }
                                if (value != _newPasswordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30),
                            CustomButton(
                              onPressed: _changePassword,
                              text: 'Change Password',
                              backgroundColor: Color(0XFF292D32),
                            ),
                          ],
                        ),
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
