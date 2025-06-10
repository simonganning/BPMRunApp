import 'package:flutter/material.dart';
import 'package:bpmapp/spotify/spotify.dart';

bool bpmState = false;

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                          iconSize: 50,
                          onPressed: () {
                            SpotifyService().prev();
                          },
                          icon:
                              Icon(Icons.navigate_before, color: Colors.white)),
                      Text(
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              color: Colors.white),
                          'Back'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          iconSize: 50,
                          onPressed: () {
                            SpotifyService().play_pause();
                          },
                          icon: Icon(Icons.not_started, color: Colors.white)),
                      Text(
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              color: Colors.white),
                          'Start/Stop'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          iconSize: 50,
                          onPressed: () {
                            SpotifyService().next();
                          },
                          icon: Icon(Icons.navigate_next, color: Colors.white)),
                      Text(
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              color: Colors.white),
                          'Next'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
