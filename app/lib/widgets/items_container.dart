import 'package:flutter/material.dart';
import 'package:app/widgets/item_card.dart';

class ItemsSection extends StatelessWidget {
  final String sectionHeader;

  const ItemsSection({
    Key? key,
    required this.sectionHeader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionHeader,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 18.75 / 16, // Line height of 18.75px
                  letterSpacing: 0.05, // 5% letter spacing
                ),
              ),
              Row(
                children: [
                  Text(
                    'See All',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey, // Adjust the color as needed
                    ),
                  ),
                  SizedBox(width: 4), // Space between text and icon
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.grey, // Adjust the color as needed
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16), // Space between header and content

        // Scrollable Row of Item Cards
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ItemCard(
                imagePath: 'assets/cardimage.png',
                price: 2500,
                text: 'Item Name',
              ),
              SizedBox(width: 16),
              ItemCard(
                imagePath: 'assets/cardimage.png',
                price: 2500,
                text: 'Item Name',
              ),
              SizedBox(width: 16),
              ItemCard(
                imagePath: 'assets/cardimage.png',
                price: 2500,
                text: 'Item Name',
              ),
              SizedBox(width: 16),
              ItemCard(
                imagePath: 'assets/cardimage.png',
                price: 2500,
                text: 'Item Name',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
