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
    health.configure(useHealthConnectIfAvailable: true);
    print('Health configured');
    await requestAuthorization();
    startTimer();
  }

  Future<void> requestAuthorization() async {
    final types = [HealthDataType.STEPS];
    bool requested = await health.requestAuthorization(types);
    print('Authorization requested: $requested');
  }

// right now having problems with getTotalStepsInInterval shwoing null when i put two dates in
// most likley becasue i dont move the iphone or because oldTime is invalid somehow
  Future<void> calculateStepsPerMinute() async {
    try {
      var now = DateTime.now();
      var oldTime = now.subtract(Duration(seconds: 60 * 60));
      var testTime = now.subtract(Duration(minutes: 1));
      stepsPerMinute =
          await health.getTotalStepsInInterval(testTime, now) ?? 160;
      print("steps is steps: $stepsPerMinute");
    } catch (e) {
      print('Error retrieving steps: $e');
    }
    setState(() {});
  }

// update bpm after every 30 sec
  void startTimer() {
    print("we are now in start timer");
    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await calculateStepsPerMinute();
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
