import 'package:app/constants/constants.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/cubit/product_cubit.dart';
import 'package:app/models/product.dart';

class AddReview extends StatefulWidget {
  final String productId;

  const AddReview({Key? key, required this.productId}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  void _submitReview() {
    if (_rating > 0 && _reviewController.text.isNotEmpty) {
      final newReview = Review(
        username: 'Mostafa Magdy',
        photoUrl: 'assets/review_userphoto.png',
        date: DateTime.now(),
        rating: _rating.toDouble(),
        header: 'Hello from shopping app',
        description: _reviewController.text,
      );

      context.read<ProductCubit>().addReview(widget.productId, newReview);

      setState(() {
        _rating = 0;
        _reviewController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review submitted successfully!')),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please provide a rating and review text')),
      );
    }
  }

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
                  headerText: 'Write Review',
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 230, 230, 230),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _rating = index + 1;
                                  });
                                },
                                child: Icon(
                                  index < _rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: const Color(0xFFFFC93E),
                                  size: 40,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: Text(
                              'Rate Product',
                              style: AppConstants.headerStyle.copyWith(
                                color: const Color(0xFF33CCCC),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'Write Review',
                            style: AppConstants.headerStyle,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _reviewController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Type your review here...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color(0xFF33CCCC), width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CustomButton(
                                onPressed: _submitReview,
                                text: 'Submit review',
                                backgroundColor: const Color(0XFF292D32),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
