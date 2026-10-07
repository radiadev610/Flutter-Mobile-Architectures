import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_translations.dart';

class EventPlannerScreen extends StatelessWidget {
  final String currentLang;

  const EventPlannerScreen({super.key, required this.currentLang});

  @override
  Widget build(BuildContext context) {
    final t = (String key) => AppTranslations.getText(currentLang, key);
    final fn = (String numStr) => AppTranslations.formatNumber(numStr, currentLang);

    final events = [
      {'title': t('event_exam'), 'date': DateTime(2026, 10, 15)},
      {'title': t('event_hackathon'), 'date': DateTime(2026, 11, 5)},
      {'title': t('event_holidays'), 'date': DateTime(2026, 11, 10)},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(t('event_title'))),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final item = events[index];
            final DateTime dt = item['date'] as DateTime;
            final String formattedDate =
                DateFormat('EEEE, dd MMMM yyyy', currentLang).format(dt);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Text(fn('${index + 1}')),
                ),
                title: Text(
                  item['title'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(fn(formattedDate)),
                trailing: const Icon(Icons.calendar_month, color: Colors.teal),
              ),
            );
          },
        ),
      ),
    );
  }
}