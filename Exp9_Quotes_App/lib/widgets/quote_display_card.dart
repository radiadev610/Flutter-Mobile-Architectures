import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/quote_model.dart';

class QuoteDisplayCard extends StatelessWidget {
  final Quote quote;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const QuoteDisplayCard({
    super.key,
    required this.quote,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  void _shareQuote(BuildContext context) {
    final String formattedText = '"${quote.content}"\n— ${quote.author}';
    Clipboard.setData(ClipboardData(text: formattedText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quote copied to clipboard for sharing!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.format_quote_rounded,
              size: 48.0,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
            const SizedBox(height: 12.0),
            Text(
              '"${quote.content}"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '— ${quote.author}',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const Divider(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  tooltip: isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.redAccent : Colors.grey,
                    size: 26.0,
                  ),
                  onPressed: onToggleFavorite,
                ),
                IconButton(
                  tooltip: 'Share / Copy Quote',
                  icon: const Icon(Icons.share_outlined, size: 24.0),
                  onPressed: () => _shareQuote(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}