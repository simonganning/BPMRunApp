import 'package:flutter/material.dart';
import 'package:bpmapp/spotify/Spotify.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final SpotifyService spotifyService = SpotifyService();
  List<String> playlists = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPlaylists();
  }

  Future<void> loadPlaylists() async {
    try {
      final fetchedPlaylists = await spotifyService.fetchPlaylists();
      setState(() {
        playlists = fetchedPlaylists;
        isLoading = false;
      });
    } catch (error) {
      print('Error loading playlists: $error');
      setState(() {
        playlists = ['Failed to fetch playlists'];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(54, 181, 34, 117),
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Column(
              children: playlists.map((playlist) {
                return Text(
                  playlist,
                  style: const TextStyle(
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
    );
  }
}
