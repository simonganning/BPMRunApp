/*

import 'package:bpmapp/spotify/spotify.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MusicPlayerSpotify {
  SpotifyService spotify = SpotifyService();
  String device_ID = "";

  Future<void> FetchDevice() async {
    final token = await spotify.getAccessToken();

    final url = Uri.parse('https://api.spotify.com/v1/me/player/devices');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final data = json.decode(response.body);
    print('API response: $data');

    final devicesRaw = data['devices'];
    if (devicesRaw == null) {
      print('No devices found or invalid response.');
      return;
    }
    print("WE ARE NOW IN DEVICES");
    final devices = devicesRaw as List;

    for (var device in devices) {
      print(device);
    }

    if (devices.isNotEmpty) {
      device_ID = devices[0]['id'];
      print('Device ID set to: $device_ID');
    }
  }
}

class AvailableDevices {
  final String id;
  AvailableDevices({
    required this.id,
  });
}
*/
