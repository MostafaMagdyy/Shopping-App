import 'package:app/constants/constants.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:app/constants/constants.dart';

class AddReview extends StatefulWidget {
  const AddReview({Key? key}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

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
                                color: Color(0xFF33CCCC),
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
                                onPressed: () {},
                                text: 'Submit review',
                                backgroundColor: Color(0XFF292D32),
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
