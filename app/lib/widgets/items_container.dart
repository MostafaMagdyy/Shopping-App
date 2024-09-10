import 'package:app/screens/new_arrival.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/item_card.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/product.dart';

class ItemsSection extends StatelessWidget {
  final String sectionHeader;
  final List<Product> products;

  const ItemsSection({
    Key? key,
    required this.sectionHeader,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool sell = sectionHeader == "New Arrival" ? false : true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionHeader,
                style: AppConstants.headerStyle,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewArrivalScreen(
                            screenType: 'New Arrival',
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: AppConstants.seeAllStyle,
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            child: Row(
              children: products.map((product) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ItemCard(
                    product: product,
                    bestSellers: sell,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
