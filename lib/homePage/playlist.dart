import 'package:flutter/material.dart';
import 'package:bpmapp/spotify/spotify.dart';
import 'package:bpmapp/spotify/spotifyPlaylist.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final ScrollController _scrollController = ScrollController();
  final SpotifyService spotifyService = SpotifyService();

  List<String> playlists = [];
  bool isLoading = false;
  int offset = 0;
  final int limit = 20;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !isLoading &&
          hasMore) {
        loadMorePlaylists();
      }
    });
    loadMorePlaylists(); // initial load
  }

  Future<void> loadMorePlaylists() async {
    setState(() => isLoading = true);
    try {
      final newPlaylists =
          await spotifyService.fetchPlaylists(offset: offset, limit: limit);

      setState(() {
        playlists.addAll(newPlaylists);
        offset += limit;
        if (newPlaylists.length < limit) {
          hasMore = false; // no more to load
        }
        isLoading = false;
      });
    } catch (e) {
      print('❌ Error fetching playlists: $e');
      setState(() => isLoading = false);
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
      child: playlists.isEmpty && isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: playlists.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == playlists.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return Text(
                  playlists[index],
                  style: const TextStyle(
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                  ),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
