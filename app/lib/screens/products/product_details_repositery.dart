import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/data/productdetails/prodcut_repositery.dart';
import './product_details.dart';
import 'package:app/cubit/product_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({Key? key, this.productId = '1'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(context.read<ProductRepository>())
        ..fetchProduct(productId),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state.products != null && state.products!.isNotEmpty) {
            final product = state.products!.first;
            return ProductDetailsView(product: product);
          } else {
            return const Center(child: Text('No product data available'));
          }
        },
      ),
    );
  }
}
