import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _allProducts = [];
  List<String> _categories = [];
  bool _isLoading = false;
  String _errorMessage = '';

  String _searchQuery = '';
  String _selectedCategory = 'all';

  List<Product> get allProducts => _allProducts;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;

  List<Product> get filteredProducts {
    return _allProducts.where((p) {
      final matchesCategory =
          _selectedCategory == 'all' || p.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch =
          p.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Future<void> loadCatalog() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final results = await Future.wait([
        _apiService.fetchProducts(),
        _apiService.fetchCategories(),
      ]);

      _allProducts = results[0] as List<Product>;
      _categories = ['all', ...(results[1] as List<String>)];
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}