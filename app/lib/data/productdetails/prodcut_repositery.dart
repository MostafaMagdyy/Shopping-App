import 'package:app/models/product.dart';
import 'package:app/data/productdetails/product.dart';

class ProductRepository {
  Future<Product> getProduct(String productId) async {
    await Future.delayed(Duration(milliseconds: 300));

    final product = productList.firstWhere(
      (p) => p.id == productId,
      orElse: () => throw Exception('Product not found'),
    );

    return product;
  }

  Future<List<Product>> getAllProducts() async {
    await Future.delayed(Duration(milliseconds: 300));

    return productList;
  }
}
