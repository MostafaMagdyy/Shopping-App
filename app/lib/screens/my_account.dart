import 'package:app/screens/address_book.dart';
import 'package:app/screens/change_password.dart';
import 'package:app/screens/my_orders.dart';
import 'package:app/screens/profile.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/country_bottom_sheet.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final List<Map<String, dynamic>> settingsItems = [
    {'imgPath': 'assets/Account/user.png', 'text': 'Your Account'},
    {'imgPath': 'assets/Account/order.png', 'text': 'Your Orders'},
    {'imgPath': 'assets/Account/heart.png', 'text': 'My Favorite'},
    {'imgPath': 'assets/Account/location.png', 'text': 'Address Book'},
    {'imgPath': 'assets/Account/lock.png', 'text': 'Change Password'},
    {'imgPath': 'assets/Account/language.png', 'text': 'Language'},
    {'imgPath': 'assets/Account/global.png', 'text': 'Country'},
    {'imgPath': 'assets/Account/information.png', 'text': 'About Us'},
    {'imgPath': 'assets/Account/message.png', 'text': 'Contact Us'},
    {'imgPath': 'assets/Account/logout.png', 'text': 'Logout'},
  ];

  String selectedCountry = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  headerText: 'My Account',
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Color.fromARGB(255, 230, 230, 230),
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    itemCount: settingsItems.length,
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = settingsItems[index];
                      return _buildSettingsItem(item, index);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(Map<String, dynamic> item, int index) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            switch (item['text']) {
              case 'Country':
                _showCountrySelection();
                break;
              case 'Change Password':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()),
                );
                break;
              case 'Your Account':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfileScreen()),
                );
                break;
              case 'Your Orders':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyOrdersScreen()),
                );
              case 'Address Book':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressBookScreen()),
                );
                break;
              default:
                break;
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Image.asset(
                  item['imgPath'],
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item['text'],
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                if (item['text'] == 'Country' && selectedCountry != '') ...[
                  Image.asset(
                    'assets/$selectedCountry.png',
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCountrySelection() {
    showCountryCodeBottomSheet(
      context,
      selectedCountry,
      (country) {
        setState(() {
          selectedCountry = country;
        });
      },
    );
  }
}
