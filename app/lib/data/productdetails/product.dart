import 'package:flutter/material.dart';
import 'package:app/models/product.dart';

final List<Product> productList = [
  Product(
    id: '1',
    name: 'Classic White T-Shirt',
    imageUrl: 'assets/productimage.png',
    isFavorite: false,
    price: 15.99,
    rating: 4.5,
    availableSizes: ['S', 'M', 'L', 'XL'],
    availableColors: [Colors.white, Colors.black, Colors.grey],
    description:
        'A comfortable and versatile white t-shirt made from 100% cotton.',
    productCode: 'CWT001',
    brand: 'EssentialWear',
    fabric: '100% Cotton',
    modelWearingSize: 'M',
    shape: 'Regular Fit',
    isBestSeller: true,
    isNewArrival: false,
    discount: 25,
    reviews: [
      Review(
        username: 'JohnDoe',
        photoUrl: 'assets/review_userphoto.png',
        date: DateTime(2022, 8, 1),
        rating: 4.0,
        header: 'Great basic tee!',
        description: 'Comfortable and fits well. Perfect for everyday wear.',
      ),
      Review(
        username: 'JaneSmith',
        photoUrl: 'assets/review_userphoto.png',
        date: DateTime(2022, 9, 15),
        rating: 5.0,
        header: 'Excellent quality',
        description: 'The fabric is soft and durable. Highly recommended!',
      ),
    ],
  ),
  Product(
    id: '2',
    name: 'Slim Fit Jeans',
    imageUrl: 'assets/productimage.png',
    isFavorite: false,
    price: 49.99,
    rating: 4.2,
    availableSizes: ['28', '30', '32', '34', '36'],
    availableColors: [Colors.blue, Colors.black],
    description:
        'Stylish slim fit jeans that offer both comfort and a modern look.',
    productCode: 'SFJ002',
    discount: 20,
    brand: 'DenimCo',
    fabric: '98% Cotton, 2% Elastane',
    modelWearingSize: '32',
    shape: 'Slim Fit',
    isBestSeller: false,
    isNewArrival: true,
    reviews: [
      Review(
        username: 'FashionLover',
        photoUrl: 'assets/review_userphoto.png',
        date: DateTime(2022, 10, 5),
        rating: 4.5,
        header: 'Great fit and style',
        description:
            'These jeans fit perfectly and look amazing. Very happy with my purchase!',
      ),
    ],
  ),
  Product(
    id: '3',
    name: 'Running Shoes',
    imageUrl: 'assets/productimage.png',
    isFavorite: false,
    price: 89.99,
    rating: 4.8,
    availableSizes: ['7', '8', '9', '10', '11', '12'],
    availableColors: [Colors.red, Colors.blue, Colors.black],
    description:
        'High-performance running shoes with superior cushioning and support.',
    productCode: 'RS003',
    brand: 'SpeedStep',
    fabric: 'Synthetic mesh upper, Rubber sole',
    modelWearingSize: '10',
    shape: 'Athletic Fit',
    discount: 25,
    isBestSeller: false,
    isNewArrival: true,
    reviews: [
      Review(
        username: 'RunnerPro',
        photoUrl: 'assets/review_userphoto.png',
        date: DateTime(2022, 11, 20),
        rating: 5.0,
        header: 'Best running shoes ever!',
        description:
            'These shoes provide excellent support and comfort. My feet feel great even after long runs.',
      ),
      Review(
        username: 'CasualJogger',
        photoUrl: 'assets/review_userphoto.png',
        date: DateTime(2022, 12, 10),
        rating: 4.5,
        header: 'Very comfortable',
        description:
            'I use these for both running and casual wear. They look good and feel great.',
      ),
    ],
  ),
];
