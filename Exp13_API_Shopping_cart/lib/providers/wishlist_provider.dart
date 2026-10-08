import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class WishlistProvider with ChangeNotifier {
  final Set<int> _wishlistIds = {};

  bool isFavorite(int productId) => _wishlistIds.contains(productId);

  void toggleFavorite(Product product) {
    if (_wishlistIds.contains(product.id)) {
      _wishlistIds.remove(product.id);
    } else {
      _wishlistIds.add(product.id);
    }
    notifyListeners();
  }

  List<Product> getFavoriteProducts(List<Product> catalog) {
    return catalog.where((p) => _wishlistIds.contains(p.id)).toList();
  }
}