import 'package:bpmapp/health/pedoMeter.dart';
import 'package:bpmapp/homePage/musicPlayerCard.dart';
import 'package:bpmapp/settingsPage/bpmCard.dart';
import 'package:bpmapp/main.dart';
import 'package:bpmapp/settingsPage/songBpmCard.dart';
import 'package:bpmapp/spotify/spotify.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class MainSettingsPage extends StatelessWidget {
  const MainSettingsPage({super.key});

  final albumUrl = "";

  // gör någon instans här av get cover image, kanske måste göra klassen till stateful
  // SpotifyService spotify = SpotifyService ();
  // future String cover = spotify.getCoverImage();

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
                  Container(
                    height: 50,
                  ),
                  Expanded(flex: 4, child: MusicPlayer()),
                  Expanded(flex: 1, child: Pedo()),
                  Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(54, 181, 34, 117)),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Go back!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  decoration: TextDecoration.none,
                                  color: Colors.white),
                            )),
                      )),
                  Container(
                    height: 20,
                  )
                ]),
          ),
        ));
  }
}
