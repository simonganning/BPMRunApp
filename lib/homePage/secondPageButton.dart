import 'package:bpmapp/secondPage/secondPage.dart';
import 'package:bpmapp/spotify/spotify.dart';
import 'package:flutter/material.dart';

class SecondPageButton extends StatefulWidget {
  final bool currentPlaylist;

  const SecondPageButton({
    super.key,
    required this.currentPlaylist,
  });

  @override
  State<SecondPageButton> createState() => _SecondPageButton();
}

class _SecondPageButton extends State<SecondPageButton> {
  @override
  Widget build(BuildContext context) {
    // Derive the title directly from currentPlaylist
    String buttonTitle = widget.currentPlaylist ? "Go" : "No playlist selected";

    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // You can also change the color based on currentPlaylist
        color: widget.currentPlaylist
            ? const Color.fromARGB(54, 181, 34, 117) // Active color
            : const Color.fromARGB(54, 100, 100, 100), // Disabled color
      ),
      child: TextButton(
        // Conditionally enable/disable the button
        onPressed: widget.currentPlaylist
            ? () async {
                SpotifyService spotify = SpotifyService();
                bool songInPlaylist = await spotify.songInPlaylist();
                if (songInPlaylist == true) {
                  //await spotify.play_pause();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondPage()),
                  );
                } else {
                  // Optionally show a message if songInPlaylist is false
                  buttonTitle = "No song in playlist";
                }
              }
            : null, // Set to null to disable the button
        child: Text(
          textAlign: TextAlign.center,
          buttonTitle, // Use the derived title
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
