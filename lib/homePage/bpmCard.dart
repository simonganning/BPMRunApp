import 'package:bpmapp/health/mainHealth.dart';
import 'package:flutter/material.dart';

class BpmCard extends StatefulWidget {
  final int? currentBPM;
  const BpmCard({super.key, this.currentBPM});

  @override
  _BpmCardState createState() => _BpmCardState();
}

class _BpmCardState extends State<BpmCard> {
  final TextEditingController myController = TextEditingController();
  int? ManuallBPM; // Variable to store the manual BPM

  @override
  void initState() {
    super.initState();

    // Start listening to changes
    myController.addListener(_handleTextFieldChange);
  }

  void _handleTextFieldChange() {
    final text = myController.text; // Get the current text
    final parsedValue = int.tryParse(text); // Try parsing it to an int
    setState(() {
      ManuallBPM = parsedValue; // Update the manual BPM value
      print('Manual BPM updated to: $ManuallBPM'); // Print the new value
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Keep transparent to match your design
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(54, 181, 34, 117),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Your current BPM',
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: HealthKitManager(),
            ),
            Expanded(
              child: TextField(
                controller: myController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Manually set BPM',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, // Ensure numeric input
              ),
            ),
          ],
        ),
      ),
    );
  }
}
