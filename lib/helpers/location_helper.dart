const GOOGLE_API_KEY = 'AIzaSyBov7Yb0Vamy1e1baa1M23eJsXMWclVc8c';

class LocationHelper {
  static String genLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
