import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

class SensorService {
  Stream<UserAccelerometerEvent> get userAccelerometerStream =>
      userAccelerometerEventStream();

  Stream<AccelerometerEvent> get accelerometerStream =>
      accelerometerEventStream();

  Stream<void> detectShake({double threshold = 15.0}) {
    late StreamController<void> controller;
    StreamSubscription? subscription;
    DateTime lastShake = DateTime.now();

    controller = StreamController<void>(
      onListen: () {
        subscription = userAccelerometerEventStream().listen((event) {
          double gForce = sqrt(
            event.x * event.x + event.y * event.y + event.z * event.z,
          );

          if (gForce > threshold) {
            final now = DateTime.now();
            if (now.difference(lastShake).inMilliseconds > 1000) {
              lastShake = now;
              controller.add(null);
            }
          }
        });
      },
      onCancel: () {
        subscription?.cancel();
      },
    );

    return controller.stream;
  }
}