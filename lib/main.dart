import 'dart:ui';

import 'package:bpmapp/health/pedoMeter.dart';
import 'package:bpmapp/homePage/musicPlayerCard.dart';
import 'package:bpmapp/homePage/playlist.dart';
import 'package:bpmapp/homePage/settingsCard.dart';
import 'package:bpmapp/spotify/spotify.dart';
import 'package:flutter/material.dart';
import 'package:bpmapp/homePage/slider.dart';

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
  RangeValues _tempoRange = const RangeValues(120, 160);

  @override
  void initState() {
    super.initState();
    print(' initState called in main');
    authenticateSpotify();
  }

  void updateTempoRange(RangeValues newRange) {
    setState(() {
      _tempoRange = newRange;
    });
  }

  Future<void> authenticateSpotify() async {
    print('Attempting to connect to Spotify...');
    await spotifyAuth.connectToSpotify();
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
                  Container(
                    height: 70,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'BPM interval for your new playlist',
                    style: TextStyle(
                        fontSize: 26,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                  Expanded(
                    flex: 1,
                    child: TempoSlider(
                      currentTempoRange: _tempoRange,
                      onRangeChnage: updateTempoRange,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Add playlists to workout',
                    style: TextStyle(
                        fontSize: 26,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                  Expanded(
                    flex: 5,
                    child: Playlist(currentTempoRange: _tempoRange),
                  ),
                  Expanded(
                    flex: 1,
                    child: SettingsCard(),
                  ),
                  Container(
                    height: 20,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
