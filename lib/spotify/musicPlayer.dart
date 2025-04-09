import 'package:bpmapp/spotify/spotify.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MusicPlayerSpotify {
  SpotifyService spotify = SpotifyService();
  String Device_ID = "";

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
    print('API response: $data'); // Debugging print

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
      Device_ID = devices[0]['id'];
      print('Device ID set to: $Device_ID');
    }
  }
/*
  PlayTrack(String track_id) async {
    var offsetVal = OffsetTrack(position: 0);
    var selectedMusic = Playtrack(
        uris: ["spotify:track:$track_id"], offset: offsetVal, positionMs: 0);

    var playIt = await http.put(
        Uri.parse(
            'https://api.spotify.com/v1/me/player/play?device_id=$Device_ID'),
        headers: {
          "Content-Type": 'application/json',
          "authorization": 'Bearer $Access_Token',
        },
        body: json.encode(selectedMusic));
  }
  */
}

class AvailableDevices {
  final String id;
  AvailableDevices({
    required this.id,
  });
}

/*
Response sample
{
  "devices": [
    {
      "id": "string",
      "is_active": false,
      "is_private_session": false,
      "is_restricted": false,
      "name": "Kitchen speaker",
      "type": "computer",
      "volume_percent": 59,
      "supports_volume": false
    }
  ]
}
*/
