import 'package:flutter/material.dart';
import 'package:bpmapp/spotify/spotify.dart';

class Playlist extends StatefulWidget {
  final RangeValues currentTempoRange;

  const Playlist({super.key, required this.currentTempoRange});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class PlaylistItem {
  final String id;
  final String name;
  final String imageUrl;
  bool isChosen;

  PlaylistItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isChosen = false,
  });
}

class _PlaylistState extends State<Playlist> {
  final ScrollController _scrollController = ScrollController();
  final SpotifyService spotifyService = SpotifyService();

  List<PlaylistItem> playlists = [];
  List<PlaylistItem> corePlaylist = [];

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
    loadMorePlaylists();
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
      print('Error fetching playlists: $e');
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
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
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

                final item = playlists[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      item.isChosen = !item.isChosen;
                      if (item.isChosen) {
                        // funktion som tar in ett playlist item
                        print(" playlist id that is choosen ${item.id}");
                        print(
                            "tempo is between ${widget.currentTempoRange.start} and ${widget.currentTempoRange.end}");
                        spotifyService.addSongsToMainPlaylist(
                            item.id, widget.currentTempoRange);
                        //  corePlaylist.add(item);
                      } else if (!item.isChosen) {
                        print('playlist id that is un -choosen ${item.id}');
                        spotifyService.deleteSongsFromMainPlaylist(item.id);
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: item.isChosen
                          ? Colors.pink.shade200
                          : const Color.fromARGB(60, 151, 77, 77),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white54),
                    ),
                    child: Row(
                      children: [
                        Image.network(item.imageUrl, width: 50, height: 50),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          item.isChosen
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: item.isChosen
                              ? Colors.greenAccent
                              : Colors.white54,
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
