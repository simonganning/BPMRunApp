import 'dart:convert';
import 'package:bpmapp/homePage/playlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyService {
  static final SpotifyService _instance = SpotifyService._internal();
  factory SpotifyService() => _instance;
  SpotifyService._internal();

  final String clientId = 'ae9c8816792d4601b642965f0a4d13b4';
  final String redirectUrl = 'spotify-ios-quick-start://spotify-login-callback';
  final String scope = 'playlist-modify-public';
  String username = "";
  String? _accessToken;
  bool? playing;
  String? main_playlistId;

  Future<void> connectToSpotify() async {
    try {
      _accessToken = await getAccessToken();
    } catch (e) {
      print('Error connecting to Spotify: $e');
    }
  }

  Future<String?> getAccessToken() async {
    if (_accessToken != null) return _accessToken;
    try {
      print("we are now in getAccessToken");
      _accessToken = await SpotifySdk.getAccessToken(
        clientId: clientId,
        redirectUrl: redirectUrl,
        scope: scope,
      );
      print("acess token is $_accessToken");
      SpotifySdk.subscribePlayerState();
      playing = true;
      await getUserId();
      await createPlaylist();
      return _accessToken;
    } catch (e) {
      print('Error retrieving access token: $e');
      playing = false;

      return null;
    }
  }

  Future<void> getUserId() async {
    final getUserIdURL = Uri.parse('https://api.spotify.com/v1/me');
    final response = await http.get(getUserIdURL, headers: {
      'Authorization': 'Bearer $_accessToken',
    });
    final data = json.decode(response.body);
    username = data['id'];
    print(' username is : $username');
  }

  // takes in a playlist iD
  // should already have created a playlist and now put all the songs from that playlist in
  // the new playlist
  Future<List<dynamic>> addSongsToMainPlaylist(String playlistID) async {
    List<dynamic> songs = [];
    final token = await getAccessToken();

    final url =
        Uri.parse('https://api.spotify.com/v1/playlists/$playlistID/tracks');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print('response is ok');
      // final data = json.decode(response.body);
      // final items = data['items'] as Map;
      Map<String, dynamic> data = jsonDecode(response.body);

      List<dynamic> items = data['items']; // make a lits with all the items

      for (var items in items) {
        var track = items['track'];
        var songId = track['id'];
        print(songId);
        songs.add(songId);
      }

      addSongsToPlaylist(songs, playlistID);
    }
    return songs;
  }

  void addSongsToPlaylist(List<dynamic> songs, String playlistId) async {
    for (var song in songs) {
      final url = Uri.parse(
          'https://api.spotify.com/v1/playlists/$main_playlistId/tracks?uris=spotify:track:$song');

      final header = {
        'Authorization': 'Bearer $_accessToken',
      };

      final response = await http.post(url, headers: header);

      if (response.statusCode == 201) {
        print("sucess");
      } else {
        print("no sucess");
      }
    } // end for loop
  }

  Future<List<PlaylistItem>> fetchPlaylists(
      {int offset = 0, int limit = 100}) async {
    final token = await getAccessToken();
    if (token == null) throw Exception('No access token');

    final url_playlists = Uri.parse(
        'https://api.spotify.com/v1/me/playlists?offset=$offset&limit=$limit');
    final response = await http.get(url_playlists, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List;
      return items.map((item) {
        return PlaylistItem(
          id: item['id'],
          name: item['name'],
          imageUrl: item['images'] != null && item['images'].isNotEmpty
              ? item['images'][0]['url']
              : 'https://api.algobook.info/v1/randomimage?category=nature', // fallback image
          isChosen: false,
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch playlists: ${response.body}');
    }
  }

  Future<void> createPlaylist() async {
    final url =
        Uri.parse('https://api.spotify.com/v1/users/$username/playlists');
    final headers = {
      'Authorization': 'Bearer $_accessToken ',
      'Content-Type': 'application/json'
    };

    final body = jsonEncode({"name": "My BPM running list", "public": "false"});
    // post the new playlist

    // if there is a playlist with that name, do not make it
    final response = await http.post(url, headers: headers, body: body);

    print('statuscode is ${response.statusCode}');

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      main_playlistId = data['id'];
      print(" made a playlist with id: $main_playlistId");
    } else {
      print(" did not make a playlist with id: $main_playlistId");
      print("Error making a playlist");
    }
  }

// for play / pause button
  Future<void> play_pause() async {
    try {
      if (playing == true) {
        await SpotifySdk.pause();
        playing = false;
      } else {
        await SpotifySdk.resume();
        playing = true;
      }
    } catch (e) {
      print('Somezing wrong');
    }
  }

  // for next song button
  Future<void> next() async {
    try {
      await SpotifySdk.skipNext();
    } catch (e) {
      print('Couln not pause the song');
    }
  }

  // for prevoius song button
  Future<void> prev() async {
    try {
      await SpotifySdk.skipPrevious();
    } catch (e) {
      print('Couln not pause the song');
    }
  }
}
