import 'package:flutter/material.dart';
import 'package:places/ui/screens/places_tab/place_screen_landscape.dart';
import 'package:places/ui/screens/places_tab/place_screen_portrait.dart';

//First tab with list of interesting places
class PlaceTabScreen extends StatelessWidget {
  const PlaceTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? const PortraitPlaceListScreen()
        : const LandscapePlaceListScreen();
  }
}
