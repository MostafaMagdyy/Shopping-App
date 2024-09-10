import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:app/models/cart_item.dart';
import 'package:app/cubit/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductCard extends StatelessWidget {
  final CartItem cartItem;

  const CartProductCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Image.asset(
                  cartItem.product.imageUrl,
                  width: 123,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.product.name,
                          style: AppConstants.headerStyle),
                      const SizedBox(height: 4),
                      Text(
                        '${cartItem.product.price.toStringAsFixed(2)} SAR',
                        style: AppConstants.seeAllStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('Sold by: ',
                              style: AppConstants.normalTextStyle),
                          Text(
                            cartItem.product.brand,
                            style: AppConstants.normalTextStyle.copyWith(
                              color: Color(0xFF38BCDD),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 240, 240, 240),
                              border: Border.all(
                                color: const Color(0xFF616161),
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                _buildQuantityButton(
                                  icon: Icons.remove,
                                  onPressed: () => _updateQuantity(context, -1),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    cartItem.quantity.toString(),
                                    style: AppConstants.headerStyle,
                                  ),
                                ),
                                _buildQuantityButton(
                                  icon: Icons.add,
                                  onPressed: () => _updateQuantity(context, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.white),
                onPressed: () => _removeFromCart(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF616161),
          width: 1.5,
        ),
      ),
      child: IconButton(
        icon: Icon(icon, size: 14),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }

  void _updateQuantity(BuildContext context, int change) {
    final cartCubit = context.read<CartCubit>();
    final newQuantity = cartItem.quantity + change;
    if (newQuantity > 0) {
      cartCubit.updateQuantity(cartItem.product.id, newQuantity);
    }
  }

  void _removeFromCart(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    cartCubit.removeFromCart(cartItem.product.id);
  }
}
