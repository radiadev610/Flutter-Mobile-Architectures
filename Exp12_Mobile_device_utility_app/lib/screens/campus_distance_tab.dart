import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/campus_location_model.dart';
import '../services/location_service.dart';

class CampusDistanceTab extends StatefulWidget {
  const CampusDistanceTab({super.key});

  @override
  State<CampusDistanceTab> createState() => _CampusDistanceTabState();
}

class _CampusDistanceTabState extends State<CampusDistanceTab> {
  final LocationService _locationService = LocationService();
  Position? _currentPosition;
  bool _isLoading = false;

  // Predefined points of interest
  final List<CampusLocationModel> _campusLocations = [
    CampusLocationModel(
      name: 'Main Academic Block / Auditorium',
      latitude: 22.3695,
      longitude: 70.7981,
    ),
    CampusLocationModel(
      name: 'Central University Library',
      latitude: 22.3701,
      longitude: 70.7988,
    ),
    CampusLocationModel(
      name: 'Student Innovation & Labs Hub',
      latitude: 22.3688,
      longitude: 70.7975,
    ),
    CampusLocationModel(
      name: 'Campus Sports Complex',
      latitude: 22.3712,
      longitude: 70.7995,
    ),
  ];

  Future<void> _fetchLocation() async {
    setState(() => _isLoading = true);
    final pos = await _locationService.getCurrentPosition();
    setState(() {
      _currentPosition = pos;
      _isLoading = false;
    });

    if (!mounted) return;
    if (pos == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot compute distance: Location denied or GPS disabled.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentPosition == null
                    ? 'Current: Unknown'
                    : 'Lat: ${_currentPosition!.latitude.toStringAsFixed(4)}, Lng: ${_currentPosition!.longitude.toStringAsFixed(4)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh),
                onPressed: _isLoading ? null : _fetchLocation,
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          const Text(
            'Distance to Predefined Campus Landmarks:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _campusLocations.length,
              itemBuilder: (context, index) {
                final loc = _campusLocations[index];
                String distanceText = 'Waiting for GPS...';

                if (_currentPosition != null) {
                  final meters = _locationService.calculateDistance(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                    loc.latitude,
                    loc.longitude,
                  );

                  distanceText = meters > 1000
                      ? '${(meters / 1000).toStringAsFixed(2)} km away'
                      : '${meters.toStringAsFixed(0)} m away';
                }

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.school),
                    ),
                    title: Text(loc.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Coord: ${loc.latitude}, ${loc.longitude}'),
                    trailing: Text(
                      distanceText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
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