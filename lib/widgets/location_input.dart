import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travel_elite/helpers/location_helper.dart';
import 'package:travel_elite/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function location;
  const LocationInput({required this.location, Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    final staticMapUrl = LocationHelper.genLocationPreviewImage(
      latitude: _locationData.latitude as double,
      longitude: _locationData.longitude as double,
    );

    setState(() {
      _previewImageUrl = staticMapUrl;
    });
    widget.location(_locationData.latitude, _locationData.longitude);
  }

  Future<void> _selectMap() async {
    final LatLng selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );

    // ignore: unnecessary_null_comparison
    if (selectedLocation == null) {
      return;
    }

    widget.location(selectedLocation.latitude, selectedLocation.longitude);

    final staticMapUrl = LocationHelper.genLocationPreviewImage(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
    );

    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Center(
                  child: Text(
                    'No location chosen',
                    textAlign: TextAlign.center,
                  ),
                )
              : Image.network(
                  _previewImageUrl.toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primary),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectMap,
              icon: const Icon(Icons.map),
              style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primary),
              label: const Text('Select on Map'),
            ),
          ],
        ),
      ],
    );
  }
}
