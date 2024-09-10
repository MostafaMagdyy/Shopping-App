import 'package:flutter/material.dart';
import 'package:app/models/product.dart';

class RatingSection extends StatelessWidget {
  final Product product;

  const RatingSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final starRatings = product.getStarRatings();
    final totalRatings = product.reviews.length;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rating',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Icon(
                            index < product.rating.round()
                                ? Icons.star
                                : Icons.star_border,
                            color: const Color(0xFFFFC93E),
                            size: 24,
                          );
                        }),
                      ),
                      Text(
                        '${product.rating.toStringAsFixed(1)}',
                        style: const TextStyle(
                            fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 5; i >= 1; i--)
                        _buildRatingRow(i, starRatings[i - 1], totalRatings),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRatingRow(int star, int count, int totalRatings) {
  final percentage = totalRatings > 0 ? (count / totalRatings) * 100 : 0.0;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text('$star', style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 4),
        Text('Star', style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey[300],
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xFFFFC93E),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            child: Text(
              '${percentage.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    ),
  );
}
