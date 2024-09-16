import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/models/product.dart';
import 'package:app/data/productdetails/prodcut_repositery.dart';

class ProductState {
  final List<Product>? products;
  final bool isLoading;
  final String? error;

  ProductState({this.products, this.isLoading = false, this.error});
}

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository;

  ProductCubit(this._repository) : super(ProductState());

  Future<void> fetchAllProducts() async {
    emit(ProductState(isLoading: true));
    try {
      final products = await _repository.getAllProducts();
      emit(ProductState(products: products));
    } catch (e) {
      emit(ProductState(error: e.toString()));
    }
  }

  Future<void> fetchProduct(String productId) async {
    emit(ProductState(isLoading: true));
    try {
      final product = await _repository.getProduct(productId);
      emit(ProductState(products: [product]));
    } catch (e) {
      emit(ProductState(error: e.toString()));
    }
  }

  Future<void> toggleFavorite(String productId) async {
    try {
      await _repository.toggleFavorite(productId);
      print("Product Id" + productId);
    } catch (e) {
      emit(ProductState(error: e.toString()));
    }
  }

  Future<void> addReview(String productId, Review newReview) async {
    try {
      await _repository.addReview(productId, newReview);

      await fetchProduct(productId);
    } catch (e) {
      emit(ProductState(error: e.toString()));
    }
  }

  Future<void> fetchFavoriteProducts() async {
    emit(ProductState(isLoading: true));
    try {
      final favoriteProducts = await _repository.getFavoriteProducts();
      emit(ProductState(products: favoriteProducts));
    } catch (e) {
      emit(ProductState(error: e.toString()));
    }
  }
}
