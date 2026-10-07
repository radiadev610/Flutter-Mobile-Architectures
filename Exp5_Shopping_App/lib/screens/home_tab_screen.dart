import 'package:flutter/material.dart';

class HomeTabScreen extends StatelessWidget {
  final VoidCallback onExploreTap;

  const HomeTabScreen({super.key, required this.onExploreTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade600, Colors.deepPurple.shade400],
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mega Clearance Sale',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6.0),
                const Text(
                  'Up to 40% OFF on all latest gadgets & lifestyle.',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 14.0),
                ElevatedButton(
                  onPressed: onExploreTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.indigo,
                  ),
                  child: const Text('Browse Products'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Featured Categories',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              _buildCategoryCard(context, Icons.devices, 'Electronics'),
              const SizedBox(width: 12.0),
              _buildCategoryCard(context, Icons.checkroom, 'Fashion'),
              const SizedBox(width: 12.0),
              _buildCategoryCard(context, Icons.chair_outlined, 'Home'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, IconData icon, String label) {
    return Expanded(
      child: InkWell(
        onTap: onExploreTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 8.0),
              Text(
                label,
                style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}