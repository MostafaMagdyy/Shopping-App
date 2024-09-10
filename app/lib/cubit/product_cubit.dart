import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/models/product.dart';
import 'package:app/data/productdetails/prodcut_repositery.dart';

class ProductState {
  final Product? product;
  final bool isLoading;
  final String? error;

  ProductState({this.product, this.isLoading = false, this.error});
}

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository;

  ProductCubit(this._repository) : super(ProductState());

  Future<void> fetchProduct(String productId) async {
    emit(ProductState(isLoading: true));
    try {
      final product = await _repository.getProduct(productId);
      emit(ProductState(product: product));
    } catch (e) {
      emit(ProductState(error: e.toString()));
    }
  }
}
