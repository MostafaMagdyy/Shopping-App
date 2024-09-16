import 'package:app/constants/constants.dart';
import 'package:app/widgets/Components/shipping_address_summary.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/Components/shipping_address_form.dart';

class AddressBookScreen extends StatefulWidget {
  @override
  _AddressBookScreenState createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  String? _selectedCountryName = "United States";
  bool _showShippingAddressForm = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  bool get hasEnteredAddress {
    return _nameController.text.isNotEmpty ||
        _streetController.text.isNotEmpty ||
        _buildingController.text.isNotEmpty ||
        _cityController.text.isNotEmpty ||
        _landmarkController.text.isNotEmpty ||
        _phoneController.text.isNotEmpty ||
        _codeController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
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
                child: const CustomHeader(
                  headerText: 'Address Book',
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 230, 230, 230),
                  child: _showShippingAddressForm
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Enter your shipping address',
                                  style: AppConstants.headerStyle.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ShippingAddressForm(
                                  context: context,
                                  nameController: _nameController,
                                  codeController: _codeController,
                                  phoneController: _phoneController,
                                  streetController: _streetController,
                                  buildingController: _buildingController,
                                  cityController: _cityController,
                                  landmarkController: _landmarkController,
                                  selectedCountryName: _selectedCountryName,
                                  onCountrySelected:
                                      (String selectedCountryName) {
                                    setState(() {
                                      _selectedCountryName =
                                          selectedCountryName;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: CustomButton(
                                    onPressed: () {
                                      setState(() {
                                        _showShippingAddressForm = false;
                                      });
                                    },
                                    backgroundColor: const Color(0XFF292D32),
                                    text: 'Add Address',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : hasEnteredAddress
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  SummaryWidget(
                                    name: _nameController.text,
                                    street: _streetController.text,
                                    buildingNumber: _buildingController.text,
                                    city: _cityController.text,
                                    onEditTap: () {
                                      setState(() {
                                        _showShippingAddressForm = true;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: const Color(0xFF292D32),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.add, size: 18),
                                          onPressed: () {},
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Add new address',
                                        style:
                                            AppConstants.headerStyle.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/NoAddress_Icon.png',
                                    width: 100,
                                    height: 100,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No Address Yet',
                                    style: AppConstants.headerStyle.copyWith(
                                      fontSize: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Please add your address for a better experience.',
                                    textAlign: TextAlign.center,
                                    style: AppConstants.normalTextStyle,
                                  ),
                                  const SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: CustomButton(
                                      onPressed: () {
                                        setState(() {
                                          _showShippingAddressForm = true;
                                        });
                                      },
                                      backgroundColor: const Color(0XFF292D32),
                                      text: 'Add Address',
                                    ),
                                  ),
                                ],
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
