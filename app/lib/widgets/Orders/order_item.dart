import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String orderNumber;
  final String price;
  final String orderDate;
  final String itemName;
  final bool isDelivered;
  final VoidCallback onWriteReview;

  const OrderItem({
    Key? key,
    required this.orderNumber,
    required this.price,
    required this.orderDate,
    required this.itemName,
    required this.isDelivered,
    required this.onWriteReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor = isDelivered ? Colors.green : Colors.red;
    String statusText = isDelivered ? 'Delivered' : 'Cancelled';

    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Order ', style: AppConstants.normalTextStyle),
                    TextSpan(
                        text: orderNumber, style: AppConstants.headerStyle),
                  ],
                ),
              ),
              Text(price, style: AppConstants.headerStyle),
            ],
          ),
          const SizedBox(height: 8),
          Text('Placed On $orderDate', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(itemName, style: AppConstants.headerStyle),
              TextButton(
                onPressed: onWriteReview,
                child: Text('Write Review',
                    style: AppConstants.seeAllStyle
                        .copyWith(color: Colors.blue, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(4, (index) {
              Color segmentColor = isDelivered ? Colors.green : Colors.red;
              return Expanded(
                child: Container(
                  height: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  color: segmentColor,
                ),
              );
            }),
          ),
          const SizedBox(height: 4),
          Text(statusText,
              style: AppConstants.headerStyle.copyWith(color: statusColor)),
        ],
      ),
    );
  }
}
