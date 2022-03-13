import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:places/app_strings.dart';
import 'package:places/colors.dart';
import 'package:places/data/mock_filters.dart';
import 'package:places/data/mock_sights.dart';
import 'package:places/domain/model/filter.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/filter_gridview.dart';
import 'package:places/ui/components/filter_range_slider.dart';
import 'package:places/ui/screens/res/themes.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var filterList = List<Filter>.from(mockFilters);
  var sightList = List<Sight>.from(mockSights);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: resetFilters,
            child: Text(
              AppStrings.cleanFiltersString,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: AppColors.lmGreen),
            ),
          ),
        ],
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              AssetImages.iconAppbarArrowPath,
              color: Colors.black,
              height: 32,
            ),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 24),
                child: Text(AppStrings.categoriesString.toUpperCase(),
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: Theme.of(context).colorScheme.subTitle)),
              ),
              FilterGridViewWidget(children: filterList, onChanged: tapFilter),
              const SizedBox(height: 30),
              MyRangeSlider(onChanged: changeRange),
              ElevatedButton(
                child: Text('${AppStrings.showString} (${sightList.length})'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetFilters() {
    setState(() {
      for (var element in filterList) {
        element.isActive = false;
      }
    });
  }

  void tapFilter(int index) {
    setState(() {
      filterList[index].isActive = !filterList[index].isActive;
    });
  }

  void changeRange(RangeValues range) async {
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

    const ky = 40000 / 360;
    var kx = cos(pi * _locationData.latitude! / 180.0) * ky;

    sightList = List<Sight>.from(mockSights).where((element) {
      var dx = (_locationData.longitude! - element.lon).abs() * kx;
      var dy = (_locationData.latitude! - element.lat).abs() * ky;
      var hypotenuse = sqrt(dx * dx + dy * dy);
      return (hypotenuse >= range.start) && (hypotenuse <= range.end);
    }).toList();

    setState(() {});
  }
}
