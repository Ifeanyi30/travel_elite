import 'dart:convert';

import './api_key.dart' show GOOGLE_API_KEY, GOOGLE_API_KEY_1;
import 'package:http/http.dart' as http;

class LocationHelper {
  static String genLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY_1");

    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
