import 'package:flutter/material.dart';
import '../models/joke_model.dart';
import '../services/joke_service.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  State<RandomJokeScreen> createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  late Future<Joke> _jokeFuture;
  bool _revealPunchline = false;

  @override
  void initState() {
    super.initState();
    _loadJoke();
  }

  void _loadJoke() {
    setState(() {
      _revealPunchline = false;
      _jokeFuture = JokeService.fetchRandomJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Jokes API')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Spacer(),
              FutureBuilder<Joke>(
                future: _jokeFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          const Icon(Icons.error_outline,
                              size: 48, color: Colors.redAccent),
                          const SizedBox(height: 8),
                          Text(snapshot.error.toString()),
                          TextButton(
                              onPressed: _loadJoke, child: const Text('Retry')),
                        ],
                      ),
                    );
                  }

                  final joke = snapshot.data!;
                  return Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            joke.setup,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16.0),
                          if (_revealPunchline)
                            Text(
                              joke.punchline,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.teal,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          else
                            OutlinedButton(
                              onPressed: () =>
                                  setState(() => _revealPunchline = true),
                              child: const Text('Reveal Punchline'),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: _loadJoke,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Next Joke'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}