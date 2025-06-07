import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:math';

class ActivityDetectionPage extends StatefulWidget {
  const ActivityDetectionPage({super.key});

  @override
  State<ActivityDetectionPage> createState() => _ActivityDetectionPageState();
}

class _ActivityDetectionPageState extends State<ActivityDetectionPage> {
  String motionType = 'Checking...';
  StreamSubscription? accelSub;
  AccelerometerEvent? reading;
  double diffThreshold = 1.5;
  int? lastTime;

  void startListening() {
    // ignore: deprecated_member_use
    accelSub = accelerometerEvents.listen((event) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (lastTime == null || now - lastTime! > 150) {
        lastTime = now;
        reading = event;
        double total = sqrt(
          event.x * event.x + event.y * event.y + event.z * event.z,
        );
        double gravityDiff = (total - 9.8).abs();

        if (gravityDiff > diffThreshold) {
          if (motionType != 'Moving') {
            setState(() {
              motionType = 'Moving';
            });
          }
        } else {
          if (motionType != 'Still') {
            setState(() {
              motionType = 'Still';
            });
          }
        }
      }
    });
  }

  void stopAndReset() {
    accelSub?.cancel();
    setState(() {
      motionType = 'Stopped';
    });
    Future.delayed(Duration(milliseconds: 120), startListening);
  }

  @override
  void dispose() {
    accelSub?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startListening();
  }

  @override
  Widget build(BuildContext context) {
    IconData iconToShow = Icons.pause_circle_filled;
    if (motionType == 'Moving') {
      iconToShow = Icons.directions_run;
    } else if (motionType == 'Still') {
      iconToShow = Icons.self_improvement;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconToShow,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(height: 20),
            Text(
              motionType,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: stopAndReset,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
