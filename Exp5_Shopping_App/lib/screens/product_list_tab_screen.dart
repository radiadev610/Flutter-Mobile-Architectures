import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductListTabScreen extends StatelessWidget {
  const ProductListTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Material(
            color: Theme.of(context).colorScheme.surface,
            elevation: 1,
            child: const TabBar(
              labelColor: Colors.indigo,
              indicatorColor: Colors.indigo,
              tabs: [
                Tab(text: 'Electronics'),
                Tab(text: 'Fashion'),
                Tab(text: 'Home'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildProductGrid(context, 'Electronics'),
                _buildProductGrid(context, 'Fashion'),
                _buildProductGrid(context, 'Home'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, String category) {
    final filtered =
        sampleProducts.where((p) => p.category == category).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final product = filtered[index];

        // Demonstrating gestures: Tap (navigate), LongPress (quick preview), DoubleTap (favorite)
        return GestureDetector(
          onTap: () {
            // Named route with arguments
            Navigator.pushNamed(
              context,
              '/product-details',
              arguments: product,
            );
          },
          onDoubleTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added "${product.title}" to Wishlist!'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(product.description),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => const Center(
                      child: Icon(Icons.image_not_supported, size: 40),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '₹${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}