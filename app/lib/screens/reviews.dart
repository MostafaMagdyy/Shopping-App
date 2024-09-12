import 'package:app/widgets/productdetails/rating.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/productdetails/review.dart';
import 'package:app/models/product.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:app/constants/constants.dart';

class ReviewsScreen extends StatelessWidget {
  final Product product;

  const ReviewsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 60,
                child: CustomHeader(
                  headerText: 'Rating and reviews',
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 230, 230, 230),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingSection(product: product),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.all(12),
                        child: const Text(
                          ' Reviews',
                          style: AppConstants.headerStyle,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: product.reviews.length,
                          itemBuilder: (context, index) {
                            return ReviewSection(
                                review: product.reviews[index]);
                          },
                        ),
                      ),
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
}
