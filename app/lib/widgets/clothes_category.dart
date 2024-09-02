import 'package:flutter/material.dart';

class ClothesCategory extends StatelessWidget {
  final String imageUrl; // Path of the image to display
  final String text; // Text to display below the image

  ClothesCategory({required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
  return Column(
      mainAxisSize: MainAxisSize
          .min, // Allows the column to take only the necessary height
      children: [
        Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0), // Circular border
            image: DecorationImage(
              image:
                  AssetImage(imageUrl), // Use AssetImage to load a local image
              fit: BoxFit.cover, // Cover the entire container
            ),
          ),
        ),
        SizedBox(height: 4.0), // Space between the image and the text
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Roboto', // Font family
            fontWeight: FontWeight.w500, // Font weight
            fontSize: 12.0, // Font size
            height: 14.06 / 12.0, // Line height as a multiple of font size
            letterSpacing: 0.05, // Letter spacing
            color: Colors.black, // Text color
          ),
        ),
      ],
    );
  }
}
