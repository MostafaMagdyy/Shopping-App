import 'package:app/models/cart_item.dart';
import 'package:app/models/product.dart';

class CartRepository {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(Product product, int quantity) {
    final existingIndex =
        _items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex != -1) {
      _items[existingIndex] = CartItem(
        product: product,
        quantity: _items[existingIndex].quantity + quantity,
      );
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
  }

  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
  }

  void updateQuantity(String productId, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      _items[index] =
          CartItem(product: _items[index].product, quantity: quantity);
    }
  }

  void clearCart() {
    _items.clear();
  }

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);
}
