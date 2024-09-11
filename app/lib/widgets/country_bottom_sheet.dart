import 'package:flutter/material.dart';
import 'button.dart';

class CountryCodeBottomSheet extends StatelessWidget {
  final String? selectedCountryCode;
  final Function(String) onSelect;

  CountryCodeBottomSheet({
    required this.selectedCountryCode,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Image.asset(
                    'assets/KSA.png',
                    width: 24,
                    height: 24,
                  ),
                  title: Text('KSA'),
                  trailing: selectedCountryCode == "+1"
                      ? Icon(Icons.check_circle, color: Colors.black)
                      : null,
                  onTap: () {
                    onSelect("KSA");
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/UAE.png',
                    width: 24,
                    height: 24,
                  ),
                  title: Text('UAE'),
                  trailing: selectedCountryCode == "+20"
                      ? Icon(Icons.check_circle, color: Colors.black)
                      : null,
                  onTap: () {
                    onSelect("UAE");
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/Egypt.png',
                    width: 24,
                    height: 24,
                  ),
                  title: Text('Egypt'),
                  trailing: selectedCountryCode == "+44"
                      ? Icon(Icons.check_circle, color: Colors.black)
                      : null,
                  onTap: () {
                    onSelect("Egypt");
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Continue',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

void showCountryCodeBottomSheet(BuildContext context,
    String? selectedCountryCode, Function(String) onSelect) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return CountryCodeBottomSheet(
        selectedCountryCode: selectedCountryCode,
        onSelect: onSelect,
      );
    },
  );
}
  