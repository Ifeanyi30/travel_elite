import 'dart:io';
import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address = '',
  });
}

class Place {
  final String id;
  final String title;
  final location;
  final File
      image; // to use the File datatype, import the dart:io dart package.

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
