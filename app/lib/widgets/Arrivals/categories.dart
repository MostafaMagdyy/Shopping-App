import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final List<String> categories = [
    'All',
    'Tops',
    'Dress',
    'Bottoms',
    'Accessories'
  ];
  String selectedCategory = 'All';

  static const Color kUnselectedBackgroundColor = Color(0xFFF5F5F5);
  static const Color kSelectedBackgroundColor = Color(0xFF292D32);
  static const Color kUnselectedTextColor = Color(0xFF636363);
  static const Color kSelectedTextColor = Color(0xFFF5F5F5);
  static const Color kBorderColor = Color(0xFF636363);

  static final TextStyle kButtonTextStyle = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 16.41 / 14,
    color: kUnselectedTextColor,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories
              .map((category) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == category
                            ? kSelectedBackgroundColor
                            : kUnselectedBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: kBorderColor, width: 1),
                        ),
                        elevation: 0,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text(
                        category,
                        style: kButtonTextStyle.copyWith(
                          color: selectedCategory == category
                              ? kSelectedTextColor
                              : kUnselectedTextColor,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
