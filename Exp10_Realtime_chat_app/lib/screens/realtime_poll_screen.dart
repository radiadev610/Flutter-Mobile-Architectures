import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RealtimePollScreen extends StatelessWidget {
  const RealtimePollScreen({super.key});

  final String _pollDocId = 'flutter_framework_poll';

  void _vote(String option) async {
    final docRef =
        FirebaseFirestore.instance.collection('polls').doc(_pollDocId);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        transaction.set(docRef, {
          'Flutter': 0,
          'React Native': 0,
          'Native Kotlin/Swift': 0,
        });
      }
      final currentVotes = (snapshot.data()?[option] as num?)?.toInt() ?? 0;
      transaction.update(docRef, {option: currentVotes + 1});
    });
  }

  @override
  Widget build(BuildContext context) {
    final docStream = FirebaseFirestore.instance
        .collection('polls')
        .doc(_pollDocId)
        .snapshots();

    return Scaffold(
      appBar: AppBar(title: const Text('Realtime Polling')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<DocumentSnapshot>(
            stream: docStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final data =
                  snapshot.data?.data() as Map<String, dynamic>? ?? {};

              final int flutterVotes = (data['Flutter'] as num?)?.toInt() ?? 0;
              final int rnVotes =
                  (data['React Native'] as num?)?.toInt() ?? 0;
              final int nativeVotes =
                  (data['Native Kotlin/Swift'] as num?)?.toInt() ?? 0;
              final int total = flutterVotes + rnVotes + nativeVotes;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'What is your preferred mobile development stack?',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text('Total votes cast: $total',
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20.0),
                  _pollTile('Flutter', flutterVotes, total, () => _vote('Flutter')),
                  _pollTile('React Native', rnVotes, total, () => _vote('React Native')),
                  _pollTile('Native Kotlin/Swift', nativeVotes, total,
                      () => _vote('Native Kotlin/Swift')),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _pollTile(String option, int votes, int total, VoidCallback onVote) {
    final double percentage = total == 0 ? 0 : votes / total;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(option, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('$votes votes (${(percentage * 100).toStringAsFixed(1)}%)'),
              ],
            ),
            const SizedBox(height: 8.0),
            LinearProgressIndicator(value: percentage, minHeight: 8.0),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.tonal(
                onPressed: onVote,
                child: const Text('Vote'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}