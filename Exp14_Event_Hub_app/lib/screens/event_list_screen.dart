import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/booking_provider.dart';
import '../providers/event_provider.dart';
import '../widgets/animated_ticket_badge.dart';
import '../widgets/event_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import 'analytics_dashboard_screen.dart';
import 'auth_screen.dart';
import 'my_tickets_screen.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventProvider>().fetchEvents();
      context.read<BookingProvider>().loadBookings();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventProvider>();
    final bookingProvider = context.watch<BookingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Analytics',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AnalyticsDashboardScreen()),
              );
            },
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.confirmation_number_outlined),
                tooltip: 'My Tickets',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MyTicketsScreen()),
                  );
                },
              ),
              if (bookingProvider.totalBookingsCount > 0)
                Positioned(
                  right: 6,
                  top: 8,
                  child: AnimatedTicketBadge(count: bookingProvider.totalBookingsCount),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AuthScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<EventProvider>().fetchEvents(),
        child: Column(
          children: [
            if (eventProvider.isOfflineBackup)
              Container(
                width: double.infinity,
                color: Colors.amber.shade700,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, size: 16, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Offline Mode: Viewing Cached Events',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: (val) => eventProvider.updateSearch(val),
                      decoration: InputDecoration(
                        hintText: 'Search events or locations...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchCtrl.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchCtrl.clear();
                                  eventProvider.updateSearch('');
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => const FilterBottomSheet(),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (eventProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (eventProvider.errorMessage.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cloud_off, size: 48, color: Colors.grey),
                          const SizedBox(height: 12),
                          Text(eventProvider.errorMessage),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => eventProvider.fetchEvents(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final displayList = eventProvider.filteredEvents;

                  if (displayList.isEmpty) {
                    return const Center(child: Text('No events matching current filter criteria.'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      return EventCard(event: displayList[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}