import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<ProductProvider>().allProducts;
    final wishlist = context.watch<WishlistProvider>();
    final favoriteProducts = wishlist.getFavoriteProducts(catalog);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Items / Wishlist'),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text('No products saved to wishlist yet.'))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: favoriteProducts[index]);
              },
            ),
    );
  }
}