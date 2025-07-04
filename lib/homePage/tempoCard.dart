import 'package:flutter/material.dart';

class TempoCard extends StatefulWidget {
  final int? currentBPM;
  const TempoCard({super.key, this.currentBPM});

  @override
  _TempoCardState createState() => _TempoCardState();
}

class _TempoCardState extends State<TempoCard> {
  final TextEditingController myController = TextEditingController();

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
      // set tempo
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
              // child: HealthKitManager(),
              child: Text('hej'),
            ),
          ],
        ),
      ),
    );
  }
}
