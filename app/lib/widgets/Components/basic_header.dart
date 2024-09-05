import 'package:flutter/material.dart';
import 'package:app/constants/constants.dart';

class BasicHeader extends StatelessWidget {
  final String headerText;
  final Widget? rightWidget;

  const BasicHeader({
    Key? key,
    required this.headerText,
    this.rightWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              headerText,
              style: AppConstants.headerStyle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          if (rightWidget != null) rightWidget!,
        ],
      ),
    );
  }
}
