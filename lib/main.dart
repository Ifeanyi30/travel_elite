import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_elite/providers/places.dart';
import 'package:travel_elite/screens/add_place_screen.dart';
import 'package:travel_elite/screens/map_screen.dart';
import 'package:travel_elite/screens/place_detail_screen.dart';
import 'package:travel_elite/screens/places_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Places(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amber),
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (cxt) => const AddPlaceScreen(),
          PlaceDetailScreen.routeName: (cxt) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
