import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/quote_model.dart';

class ApiService {
  // Public REST API endpoint for random quotes
  static const String _baseUrl = 'https://dummyjson.com/quotes/random';

  static Future<Quote> fetchRandomQuote({String? category}) async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.isEmpty) {
          throw Exception('Empty response received from the server.');
        }
        return Quote.fromJson(data);
      } else {
        throw HttpException(
            'Server responded with status code: ${response.statusCode}');
      }
    } on SocketException {
      throw const SocketException('No Internet connection. Please check your network.');
    } on TimeoutException {
      throw TimeoutException('Request timed out. The server took too long to respond.');
    } catch (e) {
      rethrow;
    }
  }
}