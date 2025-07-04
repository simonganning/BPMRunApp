import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bpmapp/spotify/spotify.dart'; // Ensure this path is correct

// bool bpmState = false; // Consider if this needs to be part of the MusicPlayer's state
// String imgUrl = ""; // This should now be managed by the StatefulWidget's state

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  String _imgUrl = ""; // Private state variable to hold the image URL
  String _currentSong = "";
  final SpotifyService _spotifyService =
      SpotifyService(); // Create an instance of your service

  @override
  void initState() {
    super.initState(); // Always call super.initState() first
    _getAlbumAndSong(); // Call the method to fetch the album cover
  }

  Future<void> nextSong() async {
    await _spotifyService.next();
  }

  // Method to fetch the album cover and update the state
  Future<void> _getAlbumAndSong() async {
    try {
      final cover = await _spotifyService.getCurrentCover();
      final song = await _spotifyService.getCurrentSong();
      setState(() {
        _imgUrl = cover; // Update the state variable
        _currentSong = song;
      });
    } catch (e) {
      print("Error getting album cover: $e");
      // Handle error, e.g., set a default error image
      setState(() {
        _imgUrl =
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Spotify_App_Logo.svg/1200px-Spotify_App_Logo.svg.png";
        _currentSong = "failed to load song name";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10), // Use const for EdgeInsets
      padding: const EdgeInsets.all(20), // Use const for EdgeInsets
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(54, 181, 34, 117),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.network(
              _imgUrl,
              fit: BoxFit.contain, // Adjust fit as needed
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child:
                      Icon(Icons.broken_image, size: 80, color: Colors.white70),
                ); // Fallback for image loading errors
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              textAlign: TextAlign.center,
              _currentSong,
              style: TextStyle(
                  fontSize: 25,
                  decoration: TextDecoration.none,
                  color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  IconButton(
                    iconSize: 50,
                    onPressed: () async {
                      await nextSong();
                      await Future.delayed(const Duration(seconds: 1));
                      await _getAlbumAndSong(); // Fetch new cover after "previous"
                    },
                    icon:
                        const Icon(Icons.navigate_before, color: Colors.white),
                  ),
                  const Text(
                    'Next', // Changed to previous for clarity
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    iconSize: 50,
                    onPressed: () {
                      _spotifyService.play_pause();
                    },
                    icon: const Icon(Icons.not_started, color: Colors.white),
                  ),
                  const Text(
                    'Start/Stop',
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    iconSize: 50,
                    onPressed: () async {
                      await nextSong(); // Assuming a previous method exists
                      await Future.delayed(
                          const Duration(seconds: 1)); // <--- ADD THIS LINE
                      await _getAlbumAndSong(); // Fetch new cover after "next"
                    },
                    icon: const Icon(Icons.navigate_next, color: Colors.white),
                  ),
                  const Text(
                    'Next',
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
