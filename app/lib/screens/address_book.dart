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

  List<Map<String, String>> savedAddresses = [];

  bool get hasEnteredAddress {
    return _nameController.text.isNotEmpty ||
        _streetController.text.isNotEmpty ||
        _buildingController.text.isNotEmpty ||
        _cityController.text.isNotEmpty ||
        _landmarkController.text.isNotEmpty ||
        _phoneController.text.isNotEmpty ||
        _codeController.text.isNotEmpty;
  }

  void _addAddress() {
    savedAddresses.add({
      'name': _nameController.text,
      'street': _streetController.text,
      'building': _buildingController.text,
      'city': _cityController.text,
      'landmark': _landmarkController.text,
      'phone': _phoneController.text,
      'code': _codeController.text,
    });

    _nameController.clear();
    _streetController.clear();
    _buildingController.clear();
    _cityController.clear();
    _landmarkController.clear();
    _phoneController.clear();
    _codeController.clear();

    setState(() {
      _showShippingAddressForm = false;
    });
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
                                    onPressed: _addAddress,
                                    backgroundColor: const Color(0XFF292D32),
                                    text: 'Add Address',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (savedAddresses.isNotEmpty) ...[
                                ...savedAddresses.map((address) {
                                  return Column(
                                    children: [
                                      SummaryWidget(
                                        name: address['name']!,
                                        street: address['street']!,
                                        buildingNumber: address['building']!,
                                        city: address['city']!,
                                        onEditTap: () {
                                          setState(() {
                                            _nameController.text =
                                                address['name']!;
                                            _streetController.text =
                                                address['street']!;
                                            _buildingController.text =
                                                address['building']!;
                                            _cityController.text =
                                                address['city']!;
                                            _landmarkController.text =
                                                address['landmark']!;
                                            _phoneController.text =
                                                address['phone']!;
                                            _codeController.text =
                                                address['code']!;
                                            _showShippingAddressForm = true;
                                          });
                                        },
                                      ),
                                      SizedBox(height: 16),
                                    ],
                                  );
                                }).toList(),
                              ] else ...[
                                Center(
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
                                        style: AppConstants.headerStyle
                                            .copyWith(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Please add your address for a better experience.',
                                        textAlign: TextAlign.center,
                                        style: AppConstants.normalTextStyle,
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ],
                              // Add New Address Button
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _showShippingAddressForm = true;
                                    });
                                  },
                                  child: Row(
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
                                        child: const Icon(
                                          Icons.add,
                                          size: 18,
                                          color: Color(0xFF292D32),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Add new address',
                                        style: AppConstants.headerStyle
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
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
            ],
          ),
        ),
      ),
    );
  }
}
