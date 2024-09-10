import 'package:flutter/material.dart';
import 'package:app/constants/constants.dart';

class SafePackagingAndReturn extends StatelessWidget {
  const SafePackagingAndReturn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final halfWidth = constraints.maxWidth / 2;
        return Container(
          color: Colors.white, // Set the background color to white
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: halfWidth,
                      child: _buildFeatureColumn(
                        icon: Icons.security,
                        title: 'Safe Packaging',
                        subtitle: 'Orders are sanitized and packed',
                      ),
                    ),
                    SizedBox(
                      width: halfWidth,
                      child: _buildFeatureColumn(
                        icon: Icons.assignment_return,
                        title: 'Easy Return',
                        subtitle: '15 Days Easy Return',
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: halfWidth - 0.5,
                  top: 10,
                  bottom: 10,
                  child: VerticalDivider(
                    color: Color(0xFFCCCCCC),
                    thickness: 2,
                    width: 3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureColumn({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: const Color(0xFF616161),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: AppConstants.headerStyle.copyWith(
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
