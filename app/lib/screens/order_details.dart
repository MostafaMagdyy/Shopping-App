import 'package:app/models/order.dart';
import 'package:app/widgets/Orders/shipment_details.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:app/data/order/orders.dart';
import 'package:app/constants/constants.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderNumber;

  const OrderDetailsScreen({Key? key, required this.orderNumber})
      : super(key: key);

  Order? _getOrderDetails(String orderNumber) {
    try {
      return sampleOrders
          .firstWhere((order) => order.orderNumber == orderNumber);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = _getOrderDetails(orderNumber);
    if (order == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Order not found',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    }

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
                child: CustomHeader(
                  headerText: 'Order ${order.orderNumber}',
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 230, 230, 230),
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildOrderDetails(),
                      SizedBox(
                        height: 12,
                      ),
                      ShipmentDetailsWidget(
                        status: order.isDelivered ? 'Delivered' : 'Cancelled',
                        estimatedDelivery: DateTime.now()
                            .add(Duration(days: order.isDelivered ? 0 : 3)),
                        orderedItems: order.orderedItems,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      _buildSummary('Payment Method', 'Credit Card Ending in',
                          value: order.paymentcardnumber),
                      SizedBox(
                        height: 12,
                      ),
                      _buildSummary(
                        'Shipping Address',
                        order.shippinglocation,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _buildOrderSummary(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _maskedCardNumber(String cardNumber) {
    if (cardNumber.length > 4) {
      return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
    }
    return cardNumber;
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
          child: Text('$value SAR',
              textAlign: TextAlign.end,
              style: label == 'Total'
                  ? AppConstants.headerStyle
                  : AppConstants.headerStyle
                      .copyWith(color: Color(0xFF616161))),
        ),
      ],
    );
  }

  Widget _buildnormalRow(String label, {String value = ""}) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: label,
                  style: AppConstants.normalTextStyle
                      .copyWith(color: Colors.black)),
              TextSpan(
                text: ' ',
              ),
              TextSpan(text: value, style: AppConstants.headerStyle),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetails() {
    final order = _getOrderDetails(orderNumber);
    if (order == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Order not found',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Details',
              style: AppConstants.headerStyle.copyWith(fontSize: 20)),
          SizedBox(height: 12),
          _buildnormalRow('Order', value: order.orderNumber),
          SizedBox(
            height: 6,
          ),
          _buildnormalRow('Placed On ${order.orderDate}'),
          SizedBox(
            height: 6,
          ),
          _buildnormalRow('Order Total',
              value: '${order.price.toStringAsFixed(0)} SAR'),
          SizedBox(
            height: 6,
          ),
          _buildnormalRow('Promo Code', value: 'MO10 Applied'),
        ],
      ),
    );
  }

  Widget _buildSummary(String header, String label, {String value = ""}) {
    if (header == "Payment Method") value = _maskedCardNumber(value);
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: AppConstants.headerStyle.copyWith(fontSize: 20)),
          SizedBox(height: 12),
          _buildnormalRow(label, value: value),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    final order = _getOrderDetails(orderNumber);
    if (order == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Order not found',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summery',
              style: AppConstants.headerStyle.copyWith(fontSize: 20)),
          SizedBox(height: 16),
          _buildRow('Items price', order.price.toStringAsFixed(0)),
          SizedBox(height: 6),
          _buildRow('Discount', '- 100'),
          SizedBox(height: 6),
          _buildRow('VAT Tax', '50'),
          SizedBox(height: 6),
          SizedBox(height: 6),
          _buildRow('Promo code ', '-30'),
          Container(
            height: 20,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          _buildRow('Total', (order.price - 80).toStringAsFixed(0)),
        ],
      ),
    );
  }
}
