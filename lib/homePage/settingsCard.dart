import 'package:bpmapp/settingsPage/mainSettingsPage.dart';
import 'package:flutter/material.dart';

bool bpmState = false;

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      // padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(54, 181, 34, 117),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainSettingsPage()),
          );
        },
        child: Text(
          textAlign: TextAlign.center,
          'Go!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              decoration: TextDecoration.none,
              color: Colors.white),
        ),
      ),
    );
  }
}
