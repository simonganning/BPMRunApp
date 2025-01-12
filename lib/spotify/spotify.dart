import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyService {
  final String clientId =
      'ae9c8816792d4601b642965f0a4d13b4'; // Replace with your client ID
  final String redirectUrl =
      'spotify-ios-quick-start://spotify-login-callback'; // Replace with your redirect URL
  String? _accessToken;

  Future<bool> connectToSpotify() async {
    try {
      return await SpotifySdk.connectToSpotifyRemote(
        clientId: clientId,
        redirectUrl: redirectUrl,
      );
    } catch (e) {
      print('Error connecting to Spotify: $e');
      return false;
    }
  }

  Future<String?> getAccessToken() async {
    if (_accessToken != null) return _accessToken;
    try {
      _accessToken = await SpotifySdk.getAccessToken(
        clientId: clientId,
        redirectUrl: redirectUrl,
        scope: 'playlist-read-private',
      );
      return _accessToken;
    } catch (e) {
      print('Error retrieving access token: $e');
      return null;
    }
  }

  Future<List<String>> fetchPlaylists() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('Failed to retrieve access token');
    }
// lägg någon plyalist här
    final url = Uri.parse('https://api.spotify.com/v1/me/playlists');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final playlists = data['items'] as List;
      return playlists.map((item) => item['name'] as String).toList();
    } else {
      throw Exception('Failed to fetch playlists');
    }
  }
}
/*
// Define your Client ID and Redirect URI
  static const String _clientId = '[your spotify client id here]';
  static const String _redirectUri =
      'spotify-ios-quick-start://spotify-login-callback';

  // Method to authorize the app
  Future<void> authorizeSpotify() async {
    try {
      // Authenticate with Spotify
      final accessToken = await SpotifySdk.getAccessToken(
        clientId: _clientId,
        redirectUrl: _redirectUri,
        scope: 'user-read-private user-read-email',
      );

      if (accessToken != null) {
        print('Spotify access token: $accessToken');
        // Use the access token for further Spotify SDK interactions
      }
    } catch (error) {
      print('Error during Spotify authorization: $error');
    }
  }

  // Configure callback to handle redirect URI
  void handleAuthCallback(String url) {
    final Uri uri = Uri.parse(url);
    final parameters = uri.queryParameters;

    if (parameters.containsKey('access_token')) {
      final accessToken = parameters['access_token'];
      print('Spotify access token: $accessToken');
    } else if (parameters.containsKey('error')) {
      final errorDescription = parameters['error'];
      print('Error during Spotify authorization: $errorDescription');
    }
  }
  */
