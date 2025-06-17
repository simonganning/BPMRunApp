import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class PedoMeter extends StatefulWidget {
  @override
  _PedoMeterState createState() => _PedoMeterState();
}

class _PedoMeterState extends State<PedoMeter> {
  int currentSteps = 0;
  int previousSteps = 0;
  DateTime? previousTimestamp;

  int stepsPerMinute = 0;

  Timer? timer;
  Stream<StepCount>? _stepCountStream;
  Stream<PedestrianStatus>? _pedestrianStatusStream;

  @override
  void initState() {
    print("initiate pedometer");
    super.initState();
    initPlatformState();
    startTimer(); // Start calculation timer
  }

  void onStepCount(StepCount event) {
    setState(() {
      currentSteps = event.steps;
      // Update previousTimestamp only if it's null (i.e. first reading)
      previousTimestamp ??= event.timeStamp;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print('Pedestrian status: ${event.status} at ${event.timeStamp}');
  }

  void onStepCountError(error) => print('Step Count Error: $error');

  void onPedestrianStatusError(error) =>
      print('Pedestrian Status Error: $error');

  Future<void> initPlatformState() async {
    _stepCountStream = await Pedometer.stepCountStream;
    _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;

    _stepCountStream?.listen(onStepCount).onError(onStepCountError);
    _pedestrianStatusStream
        ?.listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await calculateStepsPerMinute();
    });
  }

  Future<void> calculateStepsPerMinute() async {
    if (previousTimestamp == null) return;

    final now = DateTime.now();
    final timeDiff = now.difference(previousTimestamp!).inSeconds;

    final stepDiff = currentSteps - previousSteps;

    if (timeDiff > 0) {
      final spm = (stepDiff / timeDiff) * 60;
      setState(() {
        stepsPerMinute = spm.round();
        previousSteps = currentSteps;
        previousTimestamp = now;
      });
      print("Steps per minute: $stepsPerMinute");
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('$currentSteps steps',
          style: TextStyle(
              fontSize: 40,
              decoration: TextDecoration.none,
              color: Colors.white)),
    ]);
  }
}
