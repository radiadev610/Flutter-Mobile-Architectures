import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import '../services/api_service.dart';
import '../widgets/quote_display_card.dart';
import '../widgets/error_view.dart';
import 'favorite_quotes_screen.dart';

class QuoteHomeScreen extends StatefulWidget {
  const QuoteHomeScreen({super.key});

  @override
  State<QuoteHomeScreen> createState() => _QuoteHomeScreenState();
}

class _QuoteHomeScreenState extends State<QuoteHomeScreen> {
  late Future<Quote> _quoteFuture;
  final List<Quote> _favoriteQuotes = [];
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Motivation',
    'Success',
    'Life',
    'Education',
  ];

  @override
  void initState() {
    super.initState();
    _fetchNewQuote();
  }

  void _fetchNewQuote() {
    setState(() {
      _quoteFuture = ApiService.fetchRandomQuote(
        category: _selectedCategory == 'All' ? null : _selectedCategory,
      );
    });
  }

  void _toggleFavorite(Quote quote) {
    setState(() {
      final exists = _favoriteQuotes.any((q) => q.content == quote.content);
      if (exists) {
        _favoriteQuotes.removeWhere((q) => q.content == quote.content);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Removed from favorites')),
        );
      } else {
        _favoriteQuotes.add(quote);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved to favorites!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Inspirations'),
        actions: [
          IconButton(
            tooltip: 'Favorite Quotes',
            icon: const Icon(Icons.bookmark_border_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => FavoriteQuotesScreen(
                    favorites: _favoriteQuotes,
                    onRemove: (quote) => _toggleFavorite(quote),
                  ),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Random Jokes (REST API)',
            icon: const Icon(Icons.sentiment_very_satisfied),
            onPressed: () => Navigator.pushNamed(context, '/jokes'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Category Filter Bar (Post-Experiment Task 1)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (val) {
                          setState(() {
                            _selectedCategory = cat;
                          });
                          _fetchNewQuote();
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Spacer(),

              // FutureBuilder State Management
              FutureBuilder<Quote>(
                future: _quoteFuture,
                builder: (context, snapshot) {
                  // 1. Loading State
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16.0),
                          Text('Fetching inspiring quote...'),
                        ],
                      ),
                    );
                  }

                  // 2. Error State (Network failure, timeout, non-200)
                  if (snapshot.hasError) {
                    return ErrorView(
                      errorMessage: snapshot.error.toString(),
                      onRetry: _fetchNewQuote,
                    );
                  }

                  // 3. Empty Response State
                  if (!snapshot.hasData || snapshot.data!.content.isEmpty) {
                    return const Center(
                      child: Text('No quotes found. Tap button below to reload.'),
                    );
                  }

                  // 4. Successful Response State
                  final quote = snapshot.data!;
                  final isFav = _favoriteQuotes.any((q) => q.content == quote.content);

                  return QuoteDisplayCard(
                    quote: quote,
                    isFavorite: isFav,
                    onToggleFavorite: () => _toggleFavorite(quote),
                  );
                },
              ),

              const Spacer(),

              // Fetch Another Quote Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  onPressed: _fetchNewQuote,
                  icon: const Icon(Icons.autorenew_rounded),
                  label: const Text(
                    'Fetch Another Quote',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }
}