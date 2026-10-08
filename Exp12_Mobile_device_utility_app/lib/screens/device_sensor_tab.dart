import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../services/device_info_service.dart';
import '../services/sensor_service.dart';

class DeviceSensorTab extends StatefulWidget {
  const DeviceSensorTab({super.key});

  @override
  State<DeviceSensorTab> createState() => _DeviceSensorTabState();
}

class _DeviceSensorTabState extends State<DeviceSensorTab> {
  final DeviceInfoService _deviceInfoService = DeviceInfoService();
  final SensorService _sensorService = SensorService();

  Map<String, String> _deviceInfo = {};
  StreamSubscription<AccelerometerEvent>? _accelSubscription;

  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;

  @override
  void initState() {
    super.initState();
    unawaited(_loadDeviceInfo());
    _accelSubscription = _sensorService.accelerometerStream.listen((event) {
      if (mounted) {
        setState(() {
          _x = event.x;
          _y = event.y;
          _z = event.z;
        });
      }
    });
  }

  Future<void> _loadDeviceInfo() async {
    final info = await _deviceInfoService.getDeviceInfo();
    if (mounted) {
      setState(() => _deviceInfo = info);
    }
  }

  @override
  void dispose() {
    _accelSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live Accelerometer Readings',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _sensorMetric('X-Axis', _x, Colors.red),
                  _sensorMetric('Y-Axis', _y, Colors.green),
                  _sensorMetric('Z-Axis', _z, Colors.blue),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Hardware & System Information',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            child: _deviceInfo.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    children: _deviceInfo.entries
                        .map(
                          (e) => ListTile(
                            dense: true,
                            title: Text(e.key),
                            trailing: Text(
                              e.value,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _sensorMetric(String label, double value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: color)),
        const SizedBox(height: 6),
        Text(value.toStringAsFixed(2), style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}