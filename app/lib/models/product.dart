import 'package:flutter/material.dart';

class Review {
  final String username;
  final String photoUrl;
  final DateTime date;
  final double rating;
  final String header;
  final String description;

  Review({
    required this.username,
    required this.photoUrl,
    required this.date,
    required this.rating,
    required this.header,
    required this.description,
  });
}

class Product {
  final String id;
  final String name;
  final String imageUrl;
  bool isFavorite;
  final double price;
  final double rating;
  final List<String> availableSizes;
  final List<Color> availableColors;
  final String description;
  final String productCode;
  final String brand;
  final String fabric;
  final String modelWearingSize;
  final String shape;
  final List<Review> reviews;
  final bool isNewArrival;
  final bool isBestSeller;
  final int discount;
  Product(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.isFavorite,
      required this.price,
      required this.rating,
      required this.availableSizes,
      required this.availableColors,
      required this.description,
      required this.productCode,
      required this.brand,
      required this.fabric,
      required this.modelWearingSize,
      required this.shape,
      required this.reviews,
      required this.isBestSeller,
      required this.discount,
      required this.isNewArrival});

  List<int> getStarRatings() {
    List<int> starCounts = List.filled(5, 0);
    for (var review in reviews) {
      if (review.rating >= 1 && review.rating <= 5) {
        starCounts[(review.rating.round() - 1)]++;
      }
    }
    return starCounts;
  }
}
