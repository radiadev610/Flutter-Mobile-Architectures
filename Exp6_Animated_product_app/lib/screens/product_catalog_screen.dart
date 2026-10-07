import 'package:flutter/material.dart';
import '../models/product_item.dart';
import '../widgets/animated_fav_button.dart';
import '../widgets/custom_page_route.dart';
import 'product_detail_screen.dart';

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  String? _selectedCardId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Catalogue'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'View Onboarding',
            icon: const Icon(Icons.auto_stories_outlined),
            onPressed: () => Navigator.pushNamed(context, '/onboarding'),
          ),
          IconButton(
            tooltip: 'Sequential Login',
            icon: const Icon(Icons.lock_clock_outlined),
            onPressed: () => Navigator.pushNamed(context, '/login'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        itemCount: catalogProducts.length,
        itemBuilder: (context, index) {
          final product = catalogProducts[index];
          final isSelected = _selectedCardId == product.id;

          return GestureDetector(
            onTapDown: (_) => setState(() => _selectedCardId = product.id),
            onTapCancel: () => setState(() => _selectedCardId = null),
            onTap: () {
              setState(() => _selectedCardId = null);
              Navigator.of(context).push(
                CustomFadeSlideRoute(page: ProductDetailScreen(product: product)),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(vertical: isSelected ? 4.0 : 8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isSelected ? 0.18 : 0.08),
                    blurRadius: isSelected ? 16.0 : 6.0,
                    offset: Offset(0, isSelected ? 8 : 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Hero(
                    tag: 'product_img_${product.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        product.imageUrl,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => Container(
                          width: 90,
                          height: 90,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          product.tagLine,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '₹${product.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const AnimatedFavButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}