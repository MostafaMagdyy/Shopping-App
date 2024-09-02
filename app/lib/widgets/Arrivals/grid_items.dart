import 'package:flutter/material.dart';
import 'package:app/widgets/item_card.dart';

class NewArrivalGrid extends StatelessWidget {
  final int numberOfRows;

  const NewArrivalGrid({
    Key? key,
    required this.numberOfRows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(numberOfRows, (rowIndex) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0), // Space between rows
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ItemCard(
                imagePath: 'assets/cardimage.png',
                price: 2500,
                text: 'Item Name',
              ),
              SizedBox(width: 16), // Space between two ItemCards
              ItemCard(
                imagePath: 'assets/cardimage.png',
                price: 2500,
                text: 'Item Name',
              ),
            ],
          ),
        );
      }),
    );
  }
}
