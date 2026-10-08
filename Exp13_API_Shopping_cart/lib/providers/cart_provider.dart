import 'package:flutter/foundation.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import '../services/storage_service.dart';

class CartProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  final Map<int, CartItem> _items = {};

  CartProvider() {
    _restoreCart();
  }

  List<CartItem> get items => _items.values.toList();

  int get totalItemCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.values.fold(0.0, (sum, item) => sum + item.subtotal);

  double get taxRate => 0.08; // 8% sales tax
  double get taxAmount => subtotal * taxRate;
  double get finalTotal => subtotal + taxAmount;

  Future<void> _restoreCart() async {
    final storedItems = await _storageService.loadCart();
    for (final item in storedItems) {
      _items[item.product.id] = item;
    }
    notifyListeners();
  }

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += 1;
    } else {
      _items[product.id] = CartItem(product: product, quantity: 1);
    }
    _syncStorage();
  }

  void decrementQuantity(int productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity -= 1;
    } else {
      _items.remove(productId);
    }
    _syncStorage();
  }

  void removeFromCart(int productId) {
    _items.remove(productId);
    _syncStorage();
  }

  void clearCart() {
    _items.clear();
    _syncStorage();
  }

  void _syncStorage() {
    notifyListeners();
    _storageService.saveCart(_items.values.toList());
  }
}