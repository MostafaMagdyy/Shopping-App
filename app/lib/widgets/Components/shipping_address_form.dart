import 'package:flutter/material.dart';
import 'package:app/widgets/text_field.dart';
import 'package:app/widgets/country_bottom_sheet.dart';

Widget ShippingAddressForm({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController codeController,
  required TextEditingController phoneController,
  required TextEditingController streetController,
  required TextEditingController buildingController,
  required TextEditingController cityController,
  required TextEditingController landmarkController,
  required String? selectedCountryName,
  required Function(String) onCountrySelected,
}) {
  return Container(
    color: Color.fromARGB(255, 230, 230, 230),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => showCountryCodeBottomSheet(
            context,
            selectedCountryName ?? '',
            onCountrySelected,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              'Country: $selectedCountryName',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(height: 16),
        CustomTextFormField(
          labelText: 'Full Name',
          keyboardType: TextInputType.name,
          controller: nameController,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: CustomTextFormField(
                labelText: 'Code',
                keyboardType: TextInputType.number,
                controller: codeController,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 7,
              child: CustomTextFormField(
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        CustomTextFormField(
          labelText: 'Street Name',
          keyboardType: TextInputType.streetAddress,
          controller: streetController,
        ),
        SizedBox(height: 16),
        CustomTextFormField(
          labelText: 'Building Name',
          keyboardType: TextInputType.text,
          controller: buildingController,
        ),
        SizedBox(height: 16),
        CustomTextFormField(
          labelText: 'City/Area',
          keyboardType: TextInputType.text,
          controller: cityController,
        ),
        SizedBox(height: 16),
        CustomTextFormField(
          labelText: 'Nearest Landmark',
          keyboardType: TextInputType.text,
          controller: landmarkController,
        ),
        SizedBox(height: 40),
      ],
    ),
  );
}
