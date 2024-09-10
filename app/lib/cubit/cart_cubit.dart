import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/data/cart/cart_repositery.dart';
import 'package:app/models/cart_item.dart';
import 'package:app/models/product.dart';

class CartState {
  final List<CartItem> items;
  final double totalPrice;

  CartState({required this.items, required this.totalPrice});
}

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;

  CartCubit(this._repository) : super(CartState(items: [], totalPrice: 0));

  void addToCart(Product product, int quantity) {
    _repository.addToCart(product, quantity);
    _emitUpdatedState();
  }

  void removeFromCart(String productId) {
    _repository.removeFromCart(productId);
    _emitUpdatedState();
  }

  void updateQuantity(String productId, int quantity) {
    _repository.updateQuantity(productId, quantity);
    _emitUpdatedState();
  }

  void clearCart() {
    _repository.clearCart();
    _emitUpdatedState();
  }

  void _emitUpdatedState() {
    emit(CartState(
      items: _repository.items,
      totalPrice: _repository.totalPrice,
    ));
  }
}
