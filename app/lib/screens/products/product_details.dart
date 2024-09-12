import 'package:app/constants/constants.dart';
import 'package:app/screens/reviews.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/widgets/productdetails/returning_packaging.dart';
import 'package:flutter/material.dart';
import 'package:app/models/product.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:intl/intl.dart';
import 'package:app/widgets/productdetails/rating.dart';
import 'package:app/widgets/productdetails/review.dart';

import 'package:app/cubit/cart_cubit.dart';
import 'package:app/cubit/product_cubit.dart';

import 'package:app/screens/add_review.dart';

class ProductDetailsView extends StatefulWidget {
  final Product product;

  const ProductDetailsView({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late bool isFavorited;
  String selectedSize = '';
  Color? selectedColor;

  @override
  void initState() {
    super.initState();
    isFavorited = widget.product.isFavorite;
    selectedSize = widget.product.availableSizes[0];
    selectedColor = widget.product.availableColors[0];
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
              Container(
                height: 60,
                child: CustomHeader(
                  headerText: widget.product.name,
                  rightWidget: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/share.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 20),
                        Image.asset(
                          'assets/bag.png',
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 230, 230, 230),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductImage(
                          imageUrl: widget.product.imageUrl,
                          isFavorited: isFavorited,
                          onFavoriteToggle: () {
                            context
                                .read<ProductCubit>()
                                .toggleFavorite(widget.product.id);

                            setState(() {
                              isFavorited = !isFavorited;
                            });
                          },
                        ),
                        ProductInfo(product: widget.product),
                        BorderedContainer(
                          text: 'ReturnPolicy',
                        ),
                        AvailableSizes(
                          availableSizes: widget.product.availableSizes,
                          selectedSize: selectedSize,
                          onSizeSelected: (size) {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                        ),
                        AvailableColors(
                          availableColors: widget.product.availableColors,
                          selectedColor: selectedColor,
                          onColorSelected: (color) {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 24.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  'Description',
                                  style: AppConstants.headerStyle.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(widget.product.description),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              'Product Details',
                              style: AppConstants.headerStyle
                                  .copyWith(fontSize: 18),
                            ),
                          ),
                        ),
                        ProductDetails(product: widget.product),
                        const SizedBox(height: 10),
                        RatingSection(product: widget.product),
                        ReviewSection(
                          review: widget.product.reviews[0],
                          header: 'Reviews',
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewsScreen(product: widget.product),
                              ),
                            );
                          },
                          child: BorderedContainer(
                            text: 'See all reviews',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddReview(),
                              ),
                            );
                          },
                          child: BorderedContainer(
                            text: 'Write Review',
                          ),
                        ),
                        SafePackagingAndReturn(),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return CustomButton(
                                onPressed: () {
                                  final cartCubit = context.read<CartCubit>();
                                  cartCubit.addToCart(widget.product, 1);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Added to cart')),
                                  );
                                },
                                text: 'Add to cart',
                                backgroundColor: Color(0XFF292D32),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
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
}

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final bool isFavorited;
  final VoidCallback onFavoriteToggle;

  const ProductImage({
    Key? key,
    required this.imageUrl,
    required this.isFavorited,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 430,
          right: 16,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: isFavorited ? Colors.black : Colors.grey,
                size: 32,
              ),
              onPressed: onFavoriteToggle,
            ),
          ),
        ),
      ],
    );
  }
}

class ProductInfo extends StatelessWidget {
  final Product product;

  const ProductInfo({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.brand,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const Text(
                  'VAT included',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < product.rating.toInt()
                          ? Icons.star
                          : Icons.star_border,
                      color: const Color(0xFFFFC93E),
                      size: 24,
                    );
                  }),
                ),
                const SizedBox(width: 8),
                Text(
                  product.rating.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AvailableSizes extends StatelessWidget {
  final List<String> availableSizes;
  final String selectedSize;
  final ValueChanged<String> onSizeSelected;

  const AvailableSizes({
    Key? key,
    required this.availableSizes,
    required this.selectedSize,
    required this.onSizeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Size',
              style: AppConstants.headerStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: availableSizes.map((size) {
                final bool isSelected = selectedSize == size;
                return SizeButton(
                  size: size,
                  isSelected: isSelected,
                  onPressed: () => onSizeSelected(size),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class SizeButton extends StatelessWidget {
  final String size;
  final bool isSelected;
  final VoidCallback onPressed;

  const SizeButton({
    Key? key,
    required this.size,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF616161), width: 1),
        borderRadius: BorderRadius.circular(6),
        color: isSelected ? const Color(0xFF292D32) : Colors.grey[200],
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Text(
            size,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class AvailableColors extends StatelessWidget {
  final List<Color> availableColors;
  final Color? selectedColor;
  final ValueChanged<Color> onColorSelected;

  const AvailableColors({
    Key? key,
    required this.availableColors,
    required this.selectedColor,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: const Text(
              'Color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 8.0,
              children: availableColors.map((color) {
                final bool isSelected = selectedColor == color;
                return GestureDetector(
                  onTap: () {
                    onColorSelected(color);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(color: Color(0xFF616161), width: 2)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            _buildDetailRow(
                'Product Code', product.productCode, 'Brand', product.brand),
            const SizedBox(height: 8),
            _buildDetailRow('Fabric', product.fabric, 'Model Wearing Size',
                product.modelWearingSize),
            const SizedBox(height: 8),
            _buildDetailRow('Shape', product.shape, 'Shape', product.shape),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      String label1, String value1, String label2, String value2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildDetailItem(label1, value1),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildDetailItem(label2, value2),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class AllReviews extends StatelessWidget {
  final List<Review> reviews;

  const AllReviews({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Reviews',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (var review in reviews)
            Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(review.photoUrl),
                            radius: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(review.username),
                        ],
                      ),
                      Text(DateFormat('yyyy-MM-dd').format(review.date)),
                    ],
                  ),
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
                  const SizedBox(height: 4),
                  Text(review.description),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class BorderedContainer extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const BorderedContainer({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWriteReview = text == 'Write Review';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(
                color: isWriteReview ? const Color(0xFF38BCDD) : Colors.black,
              ),
            ),
            trailing: isWriteReview ? null : const Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}
