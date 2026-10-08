import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../providers/event_provider.dart';

class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final eventProvider = context.watch<EventProvider>();

    final stats = bookingProvider.bookingsPerEvent;

    return Scaffold(
      appBar: AppBar(title: const Text('Event Metrics & Stats')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _metricCard(
                  title: 'Total Revenue',
                  value: '\$${bookingProvider.totalRevenue.toStringAsFixed(2)}',
                  color: Colors.green.shade600,
                  icon: Icons.monetization_on,
                ),
                const SizedBox(width: 12),
                _metricCard(
                  title: 'Tickets Sold',
                  value: '${bookingProvider.totalTicketsBooked}',
                  color: Colors.deepPurple,
                  icon: Icons.confirmation_number,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _metricCard(
                  title: 'Active Events',
                  value: '${eventProvider.allEvents.length}',
                  color: Colors.blueAccent,
                  icon: Icons.event,
                ),
                const SizedBox(width: 12),
                _metricCard(
                  title: 'Total Orders',
                  value: '${bookingProvider.totalBookingsCount}',
                  color: Colors.orange.shade700,
                  icon: Icons.receipt_long,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Ticket Sales by Event',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (stats.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text('No transaction metrics recorded yet.'),
                ),
              )
            else
              ...stats.entries.map((entry) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    dense: true,
                    title: Text(entry.key, maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: Chip(
                      label: Text('${entry.value} seats'),
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _metricCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Card(
        color: color.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}