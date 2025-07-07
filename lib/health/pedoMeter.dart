import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cm_pedometer/cm_pedometer.dart';

class Pedo extends StatefulWidget {
  @override
  _PedoMeterState createState() => _PedoMeterState();
}

class _PedoMeterState extends State<Pedo> {
  int _currentTotalSteps = 0;
  int _previousStepsSnapshot = 0;
  DateTime? _lastSnapshotTime;
  int _stepsPerMinute = 0;
  StreamSubscription<CMPedometerData>? _pedometerSubscription;
  Timer? _calculationTimer; // Timer to trigger SPM calculation

  @override
  void initState() {
    super.initState();
    _initPedometer();
  }

  Future<void> _initPedometer() async {
    print("Initializing pedometer...");
    // 1. Request Activity Recognition permission

    print("Activity Recognition permission granted.");
    // 2. Check if step counting is available (optional but good practice)
    bool isStepCountingAvailable = await CMPedometer.isStepCountingAvailable();
    if (isStepCountingAvailable) {
      print("Step counting is available.");
      // 3. Start listening to real-time step updates
      _pedometerSubscription = CMPedometer.stepCounterFirstStream().listen(
        (CMPedometerData data) {
          setState(() {
            _currentTotalSteps = data.numberOfSteps;
            // Initialize snapshot on first data
            if (_lastSnapshotTime == null) {
              _lastSnapshotTime = DateTime.now();
              _previousStepsSnapshot = _currentTotalSteps;
            }
          });
        },
        onError: (error) {
          print('Error listening to step count stream: $error');
        },
        onDone: () {
          print('Step count stream finished.');
        },
      );

      // 4. Start a periodic timer to calculate steps per minute
      _calculationTimer = Timer.periodic(Duration(seconds: 10), (timer) {
        // Adjust interval as needed, 10-15 seconds is usually good
        _calculateStepsPerMinute();
      });
    } else {
      print("Step counting is NOT available on this device.");
      // Handle cases where sensor is not available
    }
  }

  void _calculateStepsPerMinute() {
    if (_lastSnapshotTime == null ||
        _currentTotalSteps == _previousStepsSnapshot) {
      // No initial data or no change in steps since last snapshot
      setState(() {
        _stepsPerMinute = 0;
      });
      return;
    }

    final now = DateTime.now();
    final timeDifferenceInSeconds =
        now.difference(_lastSnapshotTime!).inSeconds;

    if (timeDifferenceInSeconds > 0) {
      final stepsMoved = _currentTotalSteps - _previousStepsSnapshot;
      final spm = (stepsMoved / timeDifferenceInSeconds) * 60;

      setState(() {
        _stepsPerMinute = spm.round();
        _previousStepsSnapshot = _currentTotalSteps;
        _lastSnapshotTime = now;
      });
      print("Steps per minute: $_stepsPerMinute");
    } else {
      setState(() {
        _stepsPerMinute = 0; // Avoid division by zero
      });
    }
  }

  @override
  void dispose() {
    _pedometerSubscription?.cancel();
    _calculationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //SizedBox(height: 20),
        Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Steps/min',
              style: TextStyle(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.white),
            )),
        Text(
          "$_stepsPerMinute",
          style: TextStyle(
              fontSize: 30,
              decoration: TextDecoration.none,
              color: Colors.white),
        ),
      ],
    );
  }
}
