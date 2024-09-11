import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/text_field.dart';

class PaymentWidget extends StatefulWidget {
  final TextEditingController codeController;
  final TextEditingController nameController;
  final TextEditingController cardNumberController;
  final TextEditingController expirationDateController;
  final TextEditingController securityCodeController;

  PaymentWidget({
    required this.codeController,
    required this.nameController,
    required this.cardNumberController,
    required this.expirationDateController,
    required this.securityCodeController,
  });

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPaymentOption(context, 'Cash on Delivery', null, null),
        SizedBox(height: 10),
        _buildPaymentOption(
          context,
          'Credit Card',
          _buildCreditCardFields(),
          Row(
            children: [
              Image.asset('assets/Visa.png'),
              SizedBox(width: 4),
              Image.asset('assets/MasterCard.png'),
            ],
          ),
        ),
        SizedBox(height: 10),
        _buildPaymentOption(
          context,
          'Paymob',
          null,
          Image.asset('assets/Paymob.png'),
        ),
        SizedBox(height: 20),
        _buildPromoCodeSection(),
      ],
    );
  }

  Widget _buildPaymentOption(BuildContext context, String title,
      Widget? additionalFields, Widget? rightWidget) {
    bool isSelected = _selectedPaymentMethod == title;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = title;
        });
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isSelected ? Color(0xFF33CCCC) : Colors.transparent,
            width: isSelected ? 2 : 0,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(title, style: AppConstants.headerStyle),
                  ],
                ),
                if (rightWidget != null) rightWidget,
              ],
            ),
            if (isSelected && additionalFields != null)
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: additionalFields,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditCardFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Name on Card',
            style: AppConstants.normalTextStyle,
            textAlign: TextAlign.left,
          ),
        ),
        CustomTextFormField(
          labelText: 'Name on Card',
          controller: widget.nameController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the name on the card';
            }
            return null;
          },
          showBorderAndPlaceholder: false,
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Card Number',
            style: AppConstants.normalTextStyle,
            textAlign: TextAlign.left,
          ),
        ),
        CustomTextFormField(
          labelText: 'Card Number',
          controller: widget.cardNumberController,
          keyboardType: TextInputType.number,
          showBorderAndPlaceholder: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the card number';
            }
            if (value.length < 16 || value.length > 19) {
              return 'Card number should be between 16 and 19 digits';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Expiration Date',
                      style: AppConstants.normalTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  CustomTextFormField(
                    labelText: 'Expiration Date',
                    controller: widget.expirationDateController,
                    showBorderAndPlaceholder: false,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the expiration date';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Security Code',
                      style: AppConstants.normalTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  CustomTextFormField(
                    labelText: 'Security Code',
                    controller: widget.securityCodeController,
                    keyboardType: TextInputType.number,
                    showBorderAndPlaceholder: false,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the security code';
                      }
                      if (value.length < 3 || value.length > 4) {
                        return 'Security code should be 3 or 4 digits';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFB3B3B3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gift Cards and Promotional Codes',
              style: AppConstants.headerStyle),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: TextField(
                    controller: widget.codeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFB3B3B3), width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Enter Code',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Color(0xFF38BCDD), width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(color: Color(0xFF38BCDD)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
