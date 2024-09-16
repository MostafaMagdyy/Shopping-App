import 'package:app/constants/constants.dart';
import 'package:app/widgets/Profile/verification_popup.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/widgets/text_field.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final String initialName = "Mostafa Magdy";
  final String initialEmail = "mostafamagdy@gmail.com";
  final String initialPhone = "+01150949374";
  final String initialDate = "2002-04-02";
  final String initialPassword = "***************";
  bool _isPhoneVerified = true;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: initialName);
    _emailController = TextEditingController(text: initialEmail);
    _phoneController = TextEditingController(text: initialPhone);
    _dobController = TextEditingController(text: initialDate);
    _passwordController = TextEditingController(text: initialPassword);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dobController.text = formattedDate;
      });
    }
  }

  void _updateProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isPhoneVerified = _phoneController.text == initialPhone;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  void _showPopup(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return VerificationPopup();
      },
    );

    setState(() {
      _isPhoneVerified = true;
    });
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
                  headerText: 'Your Profile',
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 230, 230, 230),
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 12),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: AppConstants.normalTextStyle,
                          ),
                          SizedBox(height: 8),
                          CustomTextFormField(
                            showBorderAndPlaceholder: false,
                            labelText: 'Name',
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Email',
                            style: AppConstants.normalTextStyle,
                          ),
                          SizedBox(height: 8),
                          CustomTextFormField(
                            showBorderAndPlaceholder: false,
                            labelText: 'Email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Phone',
                            style: AppConstants.normalTextStyle,
                          ),
                          SizedBox(height: 8),
                          CustomTextFormField(
                            showBorderAndPlaceholder: false,
                            labelText: 'Phone',
                            controller: _phoneController,
                            suffixWidget: Padding(
                              padding: const EdgeInsets.all(16),
                              child: InkWell(
                                onTap: () {
                                  if (!_isPhoneVerified) {
                                    _showPopup(context);
                                  }
                                },
                                child: Text(
                                  _isPhoneVerified
                                      ? 'Verified'
                                      : 'Not Verified',
                                  style: AppConstants.headerStyle.copyWith(
                                    color: _isPhoneVerified
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Date of Birth',
                            style: AppConstants.normalTextStyle,
                          ),
                          SizedBox(height: 8),
                          CustomTextFormField(
                            showBorderAndPlaceholder: false,
                            labelText: 'Date of Birth',
                            suffixWidget:
                                Icon(Icons.calendar_today, color: Colors.black),
                            controller: _dobController,
                            isDateField: true,
                            onTap: () => _selectDate(context),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your date of birth';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Password',
                            style: AppConstants.normalTextStyle,
                          ),
                          SizedBox(height: 8),
                          CustomTextFormField(
                            showBorderAndPlaceholder: false,
                            labelText: 'Password',
                            obscureText: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password should be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CustomButton(
                              onPressed: _updateProfile,
                              text: 'Update profile',
                              backgroundColor: Color(0XFF292D32),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CustomButton(
                              onPressed: () {},
                              text: 'Delete Account',
                              backgroundColor: Colors.white,
                            ),
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
