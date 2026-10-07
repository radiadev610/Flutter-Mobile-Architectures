import 'package:flutter/material.dart';
import '../models/quote_model.dart';

class FavoriteQuotesScreen extends StatelessWidget {
  final List<Quote> favorites;
  final Function(Quote) onRemove;

  const FavoriteQuotesScreen({
    super.key,
    required this.favorites,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Quotes')),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No saved favorite quotes yet.',
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final item = favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ListTile(
                    leading: const Icon(Icons.bookmark, color: Colors.amber),
                    title: Text(
                      '"${item.content}"',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    subtitle: Text('— ${item.author}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () => onRemove(item),
                    ),
                  ),
                );
              },
            ),
    );
  }
}