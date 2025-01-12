import 'package:bpmapp/main.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class MainSettingsPage extends StatelessWidget {
  const MainSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                opacity: 0.6,
                image: AssetImage("assets/runner_bpmapp.png"),
                fit: BoxFit.cover)),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Settings 1 ',
                    style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Settings 2 ',
                    style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Settings 3 ',
                    style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Settings  4 ',
                    style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                    );
                  },
                  child: const Text('Go back!'),
                ),
              ],
            ),
          ),
        ));
  }
}
