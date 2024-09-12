import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/models/product.dart';

class ReviewSection extends StatelessWidget {
  final Review review;
  final String header;
const ReviewSection({Key? key, required this.review, this.header = ''})
      : super(key: key);

  String formatReviewDate(DateTime date) {
    String day = DateFormat('d').format(date);
    String suffix;
    if (day.endsWith('1') && !day.endsWith('11')) {
      suffix = 'st';
    } else if (day.endsWith('2') && !day.endsWith('12')) {
      suffix = 'nd';
    } else if (day.endsWith('3') && !day.endsWith('13')) {
      suffix = 'rd';
    } else {
      suffix = 'th';
    }
    return DateFormat("d'$suffix' MMMM yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != '')
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(header, style: AppConstants.headerStyle),
            ),
          ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE9E8E8),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(review.photoUrl),
                            radius: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(review.username),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < review.rating.toInt()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: const Color(0xFFFFC93E),
                                  size: 16,
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(formatReviewDate(review.date)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  review.header,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(review.description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
