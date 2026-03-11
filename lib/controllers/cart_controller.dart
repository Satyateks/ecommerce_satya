import 'package:get/get.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      cartItems[index].quantity += 1;
      cartItems.refresh();
    } else {
      cartItems.add(CartItemModel(product: product, quantity: 1));
    }
  }

  void increaseQuantity(int productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(int productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems.removeAt(index);
      }
      cartItems.refresh();
    }
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
  }

  void clearCart() {
    cartItems.clear();
  }

  int get totalItems {
    int total = 0;
    for (var item in cartItems) {
      total += item.quantity;
    }
    return total;
  }

  double get totalAmount {
    double total = 0;
    for (var item in cartItems) {
      total += (item.product.price ?? 0) * item.quantity;
    }
    return total;
  }
}
