import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:places/domain/store/places_store.dart';
import 'package:places/ui/components/category_tile.dart';
import 'package:provider/provider.dart';

class FilterGridViewWidget extends StatelessWidget {
  const FilterGridViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('gridview build');
    return GridViewGlowAbsorber(
      child: Observer(builder: (context) {
        log('gridview observer run', name: 'GridView');
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          shrinkWrap: true,
          itemCount: context.read<PlacesStore>().placeTypes.length,
          itemBuilder: (BuildContext context, index) {
            return FilterTile(index);
          },
        );
      }),
    );
  }
}

class GridViewGlowAbsorber extends StatelessWidget {
  final Widget child;

  const GridViewGlowAbsorber({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: child,
      onNotification: (notification) {
        if (notification is OverscrollIndicatorNotification) {
          notification.disallowIndicator();
        }
        return false;
      },
    );
  }
}
