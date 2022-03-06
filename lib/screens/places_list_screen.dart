import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_elite/providers/places.dart';
import 'package:travel_elite/screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPlaceScreen.routeName);
              },
              icon: Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future:
              Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
          builder: (context, AsyncSnapshot) =>
              AsyncSnapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Consumer<Places>(
                      builder: (context, places, child) => places.items.isEmpty
                          ? child as Widget
                          : ListView.builder(
                              itemCount: places.items.length,
                              itemBuilder: (context, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(places.items[index].image),
                                ),
                                title: Text(places.items[index].title),
                                subtitle:
                                    Text(places.items[index].location.address),
                              ),
                            ),
                      child: const Center(
                        child: Text('Got no places yet, start adding some!'),
                      ),
                    ),
        ));
  }
}
