import 'package:bpmapp/settingsPage/bpmCard.dart';
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
                    '',
                    style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    'You need a Spotify premium account for the app to work',
                    style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    'There is currently no filter on tempo or anything else since Spotify is not providing that feature at the moment. All songs are added to the modified playlist',
                    style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Your tempo (steps per minute) is shown and is calculated every 10 seconds based on ios pedometer data',
                    style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Select and deselect which playlists you want to listen to. All of the songs will be added to a temporary playlist called My BPM running list. The playlist is created anew every start of the application with zero songs',
                    style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ),
                Expanded(child: BpmCard()),
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
