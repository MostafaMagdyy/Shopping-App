import 'package:app/models/product.dart';
import 'package:app/data/productdetails/product.dart';

class ProductRepository {
  final List<Product> _productList = List.from(productList);

  Future<Product> getProduct(String productId) async {
    await Future.delayed(Duration(milliseconds: 300));

    final product = _productList.firstWhere(
      (p) => p.id == productId,
      orElse: () => throw Exception('Product not found'),
    );

    return product;
  }

  Future<List<Product>> getAllProducts() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _productList;
  }

  Future<void> toggleFavorite(String productId) async {
    await Future.delayed(Duration(milliseconds: 300));

    final productIndex = _productList.indexWhere((p) => p.id == productId);
    if (productIndex != -1) {
      _productList[productIndex].isFavorite =
          !_productList[productIndex].isFavorite;
    } else {
      throw Exception('Product not found');
    }
  }

  Future<void> addReview(String productId, Review newReview) async {
    await Future.delayed(Duration(milliseconds: 300));

    final productIndex = _productList.indexWhere((p) => p.id == productId);
    if (productIndex != -1) {
      _productList[productIndex].addReview(newReview);
    } else {
      throw Exception('Product not found');
    }
  }

  Future<List<Product>> getFavoriteProducts() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _productList.where((p) => p.isFavorite).toList();
  }
}
