import 'package:flutter/material.dart';
import 'package:app/widgets/item_card.dart';
import 'package:app/data/productdetails/product.dart';

class NewArrivalGrid extends StatelessWidget {
  final int numberOfRows;
  final bool type;
  const NewArrivalGrid(
      {Key? key, required this.numberOfRows, this.type = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(numberOfRows, (rowIndex) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    ItemCard(
                      product: productList[0],
                    ),
                    SizedBox(width: 16),
                    ItemCard(
                      product: productList[1],
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
