import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Server returned status ${response.statusCode}');
    }
  }

  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/products/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((item) => item.toString()).toList();
    } else {
      throw Exception('Unable to fetch categories');
    }
  }
}