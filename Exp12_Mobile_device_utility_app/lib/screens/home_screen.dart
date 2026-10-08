import 'package:flutter/material.dart';
import 'profile_photo_tab.dart';
import 'shake_detector_tab.dart';
import 'location_logger_tab.dart';
import 'device_sensor_tab.dart';
import 'campus_distance_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const ProfilePhotoTab(),
    const DeviceSensorTab(),
    ShakeDetectorTab(),
    const LocationLoggerTab(),
    const CampusDistanceTab(),
  ];

  final List<String> _titles = const [
    'Profile & Media',
    'Sensors & Device',
    'Shake Detector',
    'Location Logger',
    'Campus Proximity',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        elevation: 2,
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors),
            label: 'Sensors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vibration),
            label: 'Shake',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Logs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            label: 'Campus',
          ),
        ],
      ),
    );
  }
}