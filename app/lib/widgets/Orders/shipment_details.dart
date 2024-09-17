import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/models/order.dart';

class ShipmentDetailsWidget extends StatelessWidget {
  final String status;
  final DateTime estimatedDelivery;
  final List<OrderedItem> orderedItems;

  const ShipmentDetailsWidget({
    Key? key,
    required this.status,
    required this.estimatedDelivery,
    required this.orderedItems,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'cancelled':
        return Colors.red;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipment Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(4, (index) {
              Color segmentColor = _getStatusColor();
              return Expanded(
                child: Container(
                  height: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  color: segmentColor,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Text(
            status,
            style: AppConstants.headerStyle.copyWith(
              color: _getStatusColor(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Delivery estimate',
            style: AppConstants.normalTextStyle
                .copyWith(fontSize: 12, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat('EEEE, d MMMM yyyy').format(estimatedDelivery) +
                ' before 9pm',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...orderedItems.map((item) => _buildOrderedItemWidget(item)).toList(),
          BorderedContainer(context, 'Track Shipment'),
        ],
      ),
    );
  }

  Widget BorderedContainer(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderedItemWidget(OrderedItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            item.imageUrl,
            width: 86,
            height: 89,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppConstants.headerStyle),
                SizedBox(
                  height: 6,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Sold by ',
                    style: AppConstants.normalTextStyle.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: item.brand,
                        style: AppConstants.normalTextStyle
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text('QTY ${item.quantity} x ${item.price.toStringAsFixed(0)}',
                    style: AppConstants.normalTextStyle),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Write Review',
                  style: AppConstants.seeAllStyle.copyWith(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$${item.price.toStringAsFixed(0)}',
                style: AppConstants.headerStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
