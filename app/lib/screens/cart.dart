import 'package:app/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/Components/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

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
                child: const CustomHeader(
                  headerText: 'Cart',
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 230, 230, 230),
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state.items.isEmpty) {
                        return Center(
                          child: Text('Your cart is empty'),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final cartItem = state.items[index];
                          return CartProductCard(
                            cartItem: cartItem,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${state.totalPrice.toStringAsFixed(2)} SAR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
