import 'dart:ui';

import 'package:bpmapp/health/mainHealth.dart';
import 'package:bpmapp/homePage/musicPlayerCard.dart';
import 'package:bpmapp/homePage/playlist.dart';
import 'package:bpmapp/homePage/settingsCard.dart';
import 'package:bpmapp/homePage/tempoCard.dart';
import 'package:bpmapp/spotify/spotify.dart';
import 'package:bpmapp/spotify/musicPlayer.dart';
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
    authenticateSpotify();
    //  MusicPlayerSpotify player = MusicPlayerSpotify();
    // print(' GOING IN TO DEVICES');
    // player.FetchDevice();
    // print(' PASSED DEVICES');
  }

  Future<void> authenticateSpotify() async {
    final connected = await spotifyAuth.connectToSpotify();
    if (connected) {
      print(' Connected to Spotify');
    } else {
      print(' Could not connect to Spotify');
    }
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
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                        textAlign: TextAlign.center,
                        'Choose which playlists you want to listen to',
                        style: TextStyle(
                            fontSize: 26,
                            decoration: TextDecoration.none,
                            color: Colors.white),
                      )),
                  Expanded(
                    flex: 5,
                    child: Playlist(),
                  ),
                  Expanded(
                    flex: 1,
                    child: HealthKitManager(), // make a new TEMP CARD
                  ),
                  Expanded(
                    flex: 2,
                    child: MusicPlayer(),
                  ),
                  Expanded(
                    flex: 1,
                    child: SettingsCard(),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
