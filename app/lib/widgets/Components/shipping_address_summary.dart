import 'package:flutter/material.dart';
import 'package:app/constants/constants.dart';

class SummaryWidget extends StatelessWidget {
  final String name;
  final String street;
  final String buildingNumber;
  final String city;
  final VoidCallback onEditTap;

  const SummaryWidget({
    Key? key,
    required this.name,
    required this.street,
    required this.buildingNumber,
    required this.city,
    required this.onEditTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: onEditTap, // Calls the provided onEditTap function
                  child: const Text(
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
          const SizedBox(height: 16),
          _buildRow('Name', name),
          const SizedBox(height: 6),
          _buildRow('Street', street),
          const SizedBox(height: 6),
          _buildRow('Building No.', buildingNumber),
          const SizedBox(height: 6),
          _buildRow('City', city),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: Text(value),
        ),
      ],
    );
  }
}
