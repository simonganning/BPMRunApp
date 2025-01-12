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
    await getInitialSteps(); // Fetch initial steps
    startTimer();
  }

  Future<void> requestAuthorization() async {
    final types = [HealthDataType.STEPS];
    bool requested = await health.requestAuthorization(types);
    print('Authorization requested: $requested');
  }

  Future<void> getInitialSteps() async {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day);

    oldSteps = await health.getTotalStepsInInterval(midnight, now);
    print('Initial steps: $oldSteps');
  }

  Future<void> calculateStepsPerMinute() async {
    try {
      DateTime now = DateTime.now();
      DateTime midnight = DateTime(now.year, now.month, now.day);

      // Get current steps
      newSteps = await health.getTotalStepsInInterval(midnight, now);

      if (oldSteps != null && newSteps != null) {
        // Calculate steps per minute
        int stepsDifference = newSteps! - oldSteps!;
        stepsPerMinute = (stepsDifference * 2); // 30s interval -> multiply by 2
        oldSteps = newSteps; // Update old steps for next calculation

        print('New steps: $newSteps');
        print('Old steps: $oldSteps');
        print('Steps taken in last 30 seconds: $stepsDifference');
        print('Steps per minute: $stepsPerMinute');

        stepsController.text = stepsPerMinute.toString();
      } else {
        print('Failed to retrieve steps data');
      }
    } catch (e) {
      print('Error retrieving steps: $e');
    }

    setState(() {});
  }

// update bpm after every 30 sec
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 30), (timer) async {
      await calculateStepsPerMinute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('${stepsPerMinute ?? 'Loading...'}',
        style: TextStyle(
            fontSize: 20,
            decoration: TextDecoration.none,
            color: Colors.white));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}






/*


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

  Future<void> calculateStepsPerMinute() async {
    DateTime now = DateTime.now();
    DateTime tenSecondsAgo = now.subtract(Duration(seconds: 10));
    print('$now');
    print('$tenSecondsAgo');

    // Get steps from 10 seconds ago to now
    /* int? stepsNow = await health.getTotalStepsInInterval(now, now);
    int? stepsTenSecondsAgo =
        await health.getTotalStepsInInterval(tenSecondsAgo, now);
*/
    int? steps = await health.getTotalStepsInInterval(tenSecondsAgo, now);

    if (steps != null) {
      // int stepsTaken = stepsNow - stepsTenSecondsAgo;

      // Multiply by 6 to get steps per minute
      stepsPerMinute = steps * 6;
      stepsController.text = stepsPerMinute.toString();
      print('Steps per minute: $stepsPerMinute');
    } else {
      print('Failed to retrieve steps data');
    }

    setState(() {});
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      await calculateStepsPerMinute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Steps per Minute: ${stepsPerMinute ?? 'Calculating...'}',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

*/