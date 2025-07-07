import 'package:bpmapp/secondPage/secondPage.dart';
import 'package:bpmapp/spotify/spotify.dart';
import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

bool bpmState = false;

class SecondPageButton extends StatelessWidget {
  const SecondPageButton({super.key});

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
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondPage()),
          );
          SpotifyService spotify = SpotifyService();
          String playlist = spotify.getMainPlaylistID();
          final String spotifyUri = 'spotify:playlist:$playlist';
          if (spotify.is_playing() == "not_playing") {
            await SpotifySdk.play(spotifyUri: spotifyUri);
          }
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
