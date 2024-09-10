import 'package:app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/screens/cart.dart';
import 'package:app/data/productdetails/prodcut_repositery.dart';
import 'package:app/screens/products/product_details_repositery.dart';

import 'package:app/data/cart/cart_repositery.dart';
import 'package:app/cubit/product_cubit.dart';
import 'package:app/cubit/cart_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepository(),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductCubit>(
            create: (context) => ProductCubit(
              context.read<ProductRepository>(),
            ),
          ),
          BlocProvider<CartCubit>(
            create: (context) => CartCubit(
              context.read<CartRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          home: HomeScreen(),
          routes: {
            '/cart': (context) => CartScreen(),
          },
        ),
      ),
    );
  }
}
