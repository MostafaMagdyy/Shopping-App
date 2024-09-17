import 'package:app/screens/home.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:app/constants/constants.dart';
import 'package:app/widgets/Checkout/payment_step.dart';
import 'package:app/widgets/Components/shipping_address_form.dart';
import 'package:app/widgets/Components/shipping_address_summary.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalPrice;
  const CheckoutScreen({Key? key, required this.totalPrice}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 1;
  String? _selectedCountryName = "United States";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  final TextEditingController _nameControllerPayment = TextEditingController();
  final TextEditingController _codeControllerPayment = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();
  final TextEditingController _securityCodeController = TextEditingController();

  List<Map<String, String>> savedAddresses = [];

  bool _showSummary = false;
  int _editingIndex = -1;

  void _addAddress() {
    final newAddress = {
      'name': _nameController.text,
      'street': _streetController.text,
      'building': _buildingController.text,
      'city': _cityController.text,
      'landmark': _landmarkController.text,
      'phone': _phoneController.text,
      'code': _codeController.text,
    };
    setState(() {
      if (_editingIndex >= 0) {
        savedAddresses[_editingIndex] = newAddress;
        _editingIndex = -1;
      } else {
        savedAddresses.add(newAddress);
      }
      _showSummary = true;
      _clearAddressForm();
    });
  }

  void _clearAddressForm() {
    _nameController.clear();
    _streetController.clear();
    _buildingController.clear();
    _cityController.clear();
    _landmarkController.clear();
    _phoneController.clear();
    _codeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  headerText: 'Checkout',
                ),
              ),
              Expanded(
                child: Container(
                  color: currentStep == 4
                      ? Colors.white
                      : const Color.fromARGB(255, 230, 230, 230),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStepper(),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: currentStep == 4
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 50),
                                  child: Column(
                                    children: [
                                      OrderSubmitted(),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: CustomButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()),
                                            );
                                          },
                                          text: 'Go back to home',
                                          backgroundColor:
                                              const Color(0XFF292D32),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentStep == 1
                                          ? 'Enter your shipping address'
                                          : currentStep == 2
                                              ? 'Choose Payment Method'
                                              : 'Please confirm your order',
                                      style: AppConstants.headerStyle
                                          .copyWith(fontSize: 20),
                                    ),
                                    const SizedBox(height: 20),
                                    if (currentStep == 3) ...[
                                      _buildSummaryPayment(),
                                      const SizedBox(height: 12),
                                      ...savedAddresses
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final address = entry.value;
                                        return Column(
                                          children: [
                                            SummaryWidget(
                                              name: address['name'] ?? '',
                                              street: address['street'] ?? '',
                                              buildingNumber:
                                                  address['building'] ?? '',
                                              city: address['city'] ?? '',
                                              onEditTap: () {
                                                setState(() {
                                                  _editingIndex = index;
                                                  _nameController.text =
                                                      address['name'] ?? '';
                                                  _streetController.text =
                                                      address['street'] ?? '';
                                                  _buildingController.text =
                                                      address['building'] ?? '';
                                                  _cityController.text =
                                                      address['city'] ?? '';
                                                  _landmarkController.text =
                                                      address['landmark'] ?? '';
                                                  _phoneController.text =
                                                      address['phone'] ?? '';
                                                  _codeController.text =
                                                      address['code'] ?? '';
                                                  currentStep = 1;
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        );
                                      }).toList(),
                                      const SizedBox(height: 40),
                                      _buildOrderSummary(),
                                    ],
                                    if (currentStep == 2) _buildPaymentFields(),
                                    if (currentStep == 1)
                                      _showSummary
                                          ? Column(
                                              children: [
                                                ...savedAddresses
                                                    .asMap()
                                                    .entries
                                                    .map((entry) {
                                                  final index = entry.key;
                                                  final address = entry.value;
                                                  return Column(
                                                    children: [
                                                      SummaryWidget(
                                                        name: address['name'] ??
                                                            '',
                                                        street:
                                                            address['street'] ??
                                                                '',
                                                        buildingNumber: address[
                                                                'building'] ??
                                                            '',
                                                        city: address['city'] ??
                                                            '',
                                                        onEditTap: () {
                                                          setState(() {
                                                            _editingIndex =
                                                                index;
                                                            _nameController
                                                                .text = address[
                                                                    'name'] ??
                                                                '';
                                                            _streetController
                                                                .text = address[
                                                                    'street'] ??
                                                                '';
                                                            _buildingController
                                                                .text = address[
                                                                    'building'] ??
                                                                '';
                                                            _cityController
                                                                .text = address[
                                                                    'city'] ??
                                                                '';
                                                            _landmarkController
                                                                .text = address[
                                                                    'landmark'] ??
                                                                '';
                                                            _phoneController
                                                                .text = address[
                                                                    'phone'] ??
                                                                '';
                                                            _codeController
                                                                .text = address[
                                                                    'code'] ??
                                                                '';
                                                            _showSummary =
                                                                false;
                                                          });
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                    ],
                                                  );
                                                }).toList(),
                                              ],
                                            )
                                          : ShippingAddressForm(
                                              context: context,
                                              nameController: _nameController,
                                              codeController: _codeController,
                                              phoneController: _phoneController,
                                              streetController:
                                                  _streetController,
                                              buildingController:
                                                  _buildingController,
                                              cityController: _cityController,
                                              landmarkController:
                                                  _landmarkController,
                                              selectedCountryName:
                                                  _selectedCountryName,
                                              onCountrySelected:
                                                  (String selectedCountryName) {
                                                setState(() {
                                                  _selectedCountryName =
                                                      selectedCountryName;
                                                });
                                              },
                                            ),
                                    const SizedBox(height: 20),
                                    if (_showSummary && currentStep == 1)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xFF292D32),
                                                  width: 1.5,
                                                ),
                                              ),
                                              child: IconButton(
                                                icon: const Icon(Icons.add,
                                                    size: 18),
                                                onPressed: () {
                                                  setState(() {
                                                    _showSummary = false;
                                                    _editingIndex = -1;
                                                    _clearAddressForm();
                                                  });
                                                },
                                                padding: EdgeInsets.zero,
                                                constraints:
                                                    const BoxConstraints(),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              'Add new address',
                                              style: AppConstants.headerStyle
                                                  .copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (_showSummary)
                                      const SizedBox(height: 40),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: CustomButton(
                                        onPressed: () {
                                          if (currentStep == 1 &&
                                              !_showSummary) {
                                            _addAddress();
                                          } else {
                                            setState(() {
                                              currentStep++;
                                            });
                                          }
                                        },
                                        text: currentStep == 3
                                            ? 'Submit Order'
                                            : 'Confirm and continue',
                                        backgroundColor: Color(0XFF292D32),
                                      ),
                                    ),
                                  ],
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

  Widget _buildStepper() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStepIndicator(1, 'Shopping'),
          _buildStepIndicator(2, 'Payment'),
          _buildStepIndicator(3, 'Review'),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label) {
    bool isCurrentStep = step == currentStep;
    bool isDone = step < currentStep;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone
                ? Color(0xFF33CCCC)
                : (isCurrentStep ? Colors.black : Colors.grey),
          ),
          child: Center(
            child: isDone
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    '$step',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: isCurrentStep || isDone ? Colors.black : Colors.grey,
            fontWeight:
                isCurrentStep || isDone ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  String _maskedCardNumber(String cardNumber) {
    if (cardNumber.length > 4) {
      return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
    }
    return cardNumber;
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: AppConstants.headerStyle),
          SizedBox(height: 16),
          _buildRow('Subtotal', widget.totalPrice.toStringAsFixed(2)),
          SizedBox(height: 6),
          _buildRow(
              'Shipping Fee', (0.1 * widget.totalPrice).toStringAsFixed(2)),
          SizedBox(height: 6),
          _buildRow('Total',
              (widget.totalPrice + 0.1 * widget.totalPrice).toStringAsFixed(2)),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSummaryPayment() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Payment', style: AppConstants.headerStyle),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentStep = 2;
                    });
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Color(0xFF33CCCC),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildRow(_maskedCardNumber(_cardNumberController.text),
              _expirationDateController.text),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(label,
              style: label == 'Total'
                  ? AppConstants.headerStyle
                  : AppConstants.normalTextStyle),
        ),
        Expanded(
          child: Text(value,
              textAlign: TextAlign.end,
              style: label == 'Total'
                  ? AppConstants.headerStyle
                  : AppConstants.headerStyle.copyWith(
                      fontWeight: FontWeight.w400,
                    )),
        ),
      ],
    );
  }

  Widget OrderSubmitted() {
    return Center(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/complete.png',
              width: 120,
              height: 120,
            ),
            SizedBox(height: 24),
            Text(
              'We Get it!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Your order submitted successfully.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'You will get notifications for your order’s state.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentFields() {
    return PaymentWidget(
      codeController: _codeControllerPayment,
      nameController: _nameControllerPayment,
      cardNumberController: _cardNumberController,
      expirationDateController: _expirationDateController,
      securityCodeController: _securityCodeController,
    );
  }
}
