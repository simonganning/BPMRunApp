import 'dart:async';
import 'package:flutter/material.dart';
import 'package:health/health.dart';

class HealthKitManager extends StatefulWidget {
  @override
  _HealthKitManagerState createState() => _HealthKitManagerState();
}

class _HealthKitManagerState extends State<HealthKitManager> {
  final Health health = Health();
  Timer? timer;
  int? stepsPerMinute;
  int? oldSteps;
  int? newSteps;
  final TextEditingController stepsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeHealth();
  }

  Future<void> initializeHealth() async {
    await health.configure();
    // health.configure(useHealthConnectIfAvailable: true); //old version 10.0.0
    print('Health configured');
    await requestAuthorization();
    startTimer();
  }

  Future<void> requestAuthorization() async {
    final types = [HealthDataType.STEPS];
    bool requested = await health.requestAuthorization(types);
    print('Authorization requested: $requested');
    if (!requested) {
      print('--- HEALTHKIT AUTH FAILED! Steps permission not granted. ---');
    }
  }

// right now having problems with getTotalStepsInInterval shwoing null when i put two dates in
// most likley becasue i dont move the iphone or because oldTime is invalid somehow
  Future<void> getStepsPerMinute() async {
    try {
      var now = DateTime.now();
      final sevenDaysAgo = now.subtract(const Duration(days: 7));
      final startOfWeekInterval = DateTime(
        sevenDaysAgo.year,
        sevenDaysAgo.month,
        sevenDaysAgo.day,
      );

      var testTime = DateTime(
        now.year,
        now.month,
        now.day,
      );
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: testTime,
        endTime: now,
      );
      for (final point in healthData) {
        print("Got health data: ${point.value} at ${point.dateFrom}");
      }
      print(" testtime : $startOfWeekInterval and now time $now");
      var oldTime = now.subtract(Duration(minutes: 1));
      stepsPerMinute =
          await health.getTotalStepsInInterval(startOfWeekInterval, now);
      print("steps is: $stepsPerMinute");
    } catch (e) {
      print('Error retrieving steps: $e');
    }
    setState(() {});
  }

// update bpm after every 30 sec
  void startTimer() {
    print("we are now in start timer");
    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await getStepsPerMinute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('${stepsPerMinute ?? 'Tempo'}',
        style: TextStyle(
            fontSize: 40,
            decoration: TextDecoration.none,
            color: Colors.white));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
