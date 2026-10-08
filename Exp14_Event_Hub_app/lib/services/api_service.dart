import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class ApiService {
  static const String _mockApiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<EventModel>> fetchEvents() async {
    final response = await http.get(Uri.parse(_mockApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final categories = ['Tech', 'Music', 'Design', 'Business'];
      final locations = ['Hall A', 'Convention Center', 'Main Auditorium', 'Tech Park'];

      return List.generate(12, (index) {
        final item = data[index];
        final price = (index + 1) * 15.0;
        final category = categories[index % categories.length];
        final location = locations[index % locations.length];

        return EventModel(
          id: 'EVT-${item['id']}',
          title: 'Summit: ${item['title'].toString().substring(0, 18)}',
          category: category,
          date: '2026-11-${10 + index}',
          location: location,
          price: price,
          totalSeats: 100,
          availableSeats: 100 - (index * 7),
          imageUrl: 'https://picsum.photos/seed/evt${item['id']}/400/250',
          description: item['body'] as String,
        );
      });
    } else {
      throw Exception('Failed to load remote events.');
    }
  }
}