import 'package:flutter/material.dart';
import 'chat_screen.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  final List<Map<String, String>> _rooms = const [
    {'id': 'general', 'title': '🌐 General Discussion', 'desc': 'Open chat for everyone'},
    {'id': 'flutter', 'title': '📱 Flutter Devs', 'desc': 'Widgets, architecture, and code'},
    {'id': 'exams', 'title': '📚 University Exams', 'desc': 'Assignments & study notes'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Chat Room')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _rooms.length,
        itemBuilder: (context, index) {
          final room = _rooms[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            child: ListTile(
              title: Text(room['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(room['desc']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ChatScreen(
                      roomId: room['id']!,
                      currentUsername: 'Dev',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}