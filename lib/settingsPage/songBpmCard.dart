import 'package:flutter/material.dart';

bool bpmState = false;

class songBPMCard extends StatelessWidget {
  const songBPMCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      textAlign: TextAlign.center,
      'Song BPM will be here',
      style: TextStyle(
          fontSize: 26, decoration: TextDecoration.none, color: Colors.white),
    ));
  }
}
