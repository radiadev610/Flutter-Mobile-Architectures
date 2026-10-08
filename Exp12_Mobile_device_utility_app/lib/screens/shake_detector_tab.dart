import 'dart:async';
import 'package:flutter/material.dart';
import '../services/sensor_service.dart';

class ShakeDetectorTab extends StatefulWidget {
  const ShakeDetectorTab({super.key});

  @override
  State<ShakeDetectorTab> createState() => _ShakeDetectorTabState();
}

class _ShakeDetectorTabState extends State<ShakeDetectorTab> {
  final SensorService _sensorService = SensorService();
  StreamSubscription? _shakeSubscription;
  int _shakeCounter = 0;
  Color _backgroundColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _shakeSubscription = _sensorService.detectShake(threshold: 14.0).listen((_) {
      if (!mounted) return;
      setState(() {
        _shakeCounter++;
        _backgroundColor = Colors.teal.shade100;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Shake #$_shakeCounter detected!'),
          duration: const Duration(milliseconds: 700),
        ),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() => _backgroundColor = Colors.transparent);
        }
      });
    });
  }

  @override
  void dispose() {
    _shakeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: _backgroundColor,
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.vibration, size: 80, color: Colors.teal),
            const SizedBox(height: 16),
            const Text(
              'Shake Your Phone',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Uses UserAccelerometer dynamic event stream',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Text(
              'Shake Count: $_shakeCounter',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => setState(() => _shakeCounter = 0),
              child: const Text('Reset Count'),
            ),
          ],
        ),
      ),
    );
  }
}