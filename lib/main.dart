import 'dart:ui';

import 'package:bpmapp/homePage/bpmCard.dart';
import 'package:bpmapp/homePage/playlist.dart';
import 'package:bpmapp/homePage/settingsCard.dart';
import 'package:bpmapp/spotify/spotify.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SpotifyService spotifyAuth = SpotifyService();

  @override
  void initState() {
    super.initState();
    SpotifyService();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
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
                children: [
                  Expanded(
                    child: Text(
                      'BPM run app',
                      style: TextStyle(
                          fontSize: 30,
                          decoration: TextDecoration.none,
                          color: Colors.white),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    'What music should we play?',
                    style: TextStyle(
                        fontSize: 24,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  )),
                  Expanded(
                    flex: 3,
                    child: Playlist(),
                  ),
                  Expanded(
                    flex: 2,
                    child: BpmCard(),
                  ),
                  Expanded(
                    flex: 2,
                    child: SettingsCard(),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
