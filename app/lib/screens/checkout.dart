import 'package:app/screens/home.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/text_field.dart';
import 'package:app/widgets/country_bottom_sheet.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:app/constants/constants.dart';
import 'package:app/widgets/Checkout/payment_step.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
  final double totalPrice;
  const CheckoutScreen({Key? key, required this.totalPrice}) : super(key: key);
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

  bool _showSummary = false;

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
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: currentStep == 4
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 50),
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
                                          backgroundColor: Color(0XFF292D32),
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
                                    SizedBox(height: 20),
                                    if (currentStep == 3) ...[
                                      _buildSummaryPayment(),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      _buildSummary(),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      _buildOrderSummary()
                                    ],
                                    if (currentStep == 2) _buildPaymentFields(),
                                    if (currentStep == 1)
                                      (_showSummary
                                          ? _buildSummary()
                                          : _buildForm()),
                                    SizedBox(height: 20),
                                    if (_showSummary)
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
                                                icon: Icon(Icons.add, size: 18),
                                                onPressed: () {},
                                                padding: EdgeInsets.zero,
                                                constraints:
                                                    const BoxConstraints(),
                                              ),
                                            ),
                                            SizedBox(width: 10),
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
                                    if (_showSummary) SizedBox(height: 40),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: CustomButton(
                                        onPressed: () {
                                          setState(() {
                                            if (currentStep == 1) {
                                              _showSummary = !_showSummary;
                                              if (!_showSummary) currentStep++;
                                            } else
                                              currentStep++;
                                          });
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

  Widget _buildForm() {
    return Container(
      color: Color.fromARGB(255, 230, 230, 230),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => showCountryCodeBottomSheet(
              context,
              _selectedCountryName ?? '',
              (String selectedCountryName) {
                setState(() {
                  _selectedCountryName = selectedCountryName;
                });
              },
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                'Country: $_selectedCountryName',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'Full Name',
            keyboardType: TextInputType.name,
            controller: _nameController,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomTextFormField(
                  labelText: 'Code',
                  keyboardType: TextInputType.number,
                  controller: _codeController,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 7,
                child: CustomTextFormField(
                  labelText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'Street Name',
            keyboardType: TextInputType.streetAddress,
            controller: _streetController,
          ),
          SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'Building Name',
            keyboardType: TextInputType.text,
            controller: _buildingController,
          ),
          SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'City/Area',
            keyboardType: TextInputType.text,
            controller: _cityController,
          ),
          SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'Nearest Landmark',
            keyboardType: TextInputType.text,
            controller: _landmarkController,
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSummary() {
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
              Text('Shipping address', style: AppConstants.headerStyle),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showSummary = !_showSummary;
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
          _buildRow('Name', _nameController.text),
          SizedBox(height: 6),
          _buildRow('Street', _streetController.text),
          SizedBox(height: 6),
          _buildRow('Building No.', _buildingController.text),
          SizedBox(height: 6),
          _buildRow('City', _cityController.text),
          SizedBox(height: 16),
        ],
      ),
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
