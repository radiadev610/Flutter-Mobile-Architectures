import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/location_log_model.dart';
import '../services/location_service.dart';

class LocationLoggerTab extends StatefulWidget {
  const LocationLoggerTab({super.key});

  @override
  State<LocationLoggerTab> createState() => _LocationLoggerTabState();
}

class _LocationLoggerTabState extends State<LocationLoggerTab> {
  final LocationService _locationService = LocationService();
  final List<LocationLogModel> _logs = [];
  bool _isLoading = false;

  Future<void> _recordCurrentLocation() async {
    setState(() => _isLoading = true);
    final position = await _locationService.getCurrentPosition();
    setState(() => _isLoading = false);

    if (!mounted) return;

    if (position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get location. Enable GPS & Permissions.')),
      );
      return;
    }

    setState(() {
      _logs.insert(
        0,
        LocationLogModel(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm:ss a');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _recordCurrentLocation,
              icon: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.add_location_alt),
              label: const Text('Log Current GPS Location'),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _logs.isEmpty
                ? const Center(child: Text('No location checkpoints recorded yet.'))
                : ListView.builder(
                    itemCount: _logs.length,
                    itemBuilder: (context, index) {
                      final item = _logs[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: const Icon(Icons.pin_drop, color: Colors.indigo),
                          title: Text(
                            'Lat: ${item.latitude.toStringAsFixed(5)}, Lng: ${item.longitude.toStringAsFixed(5)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(dateFormat.format(item.timestamp)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}