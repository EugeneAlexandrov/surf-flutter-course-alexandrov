import 'package:flutter/material.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/ui/components/filter_tile.dart';
import 'package:provider/provider.dart';

class FilterGridViewWidget extends StatelessWidget {
  const FilterGridViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridViewGlowAbsorber(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        shrinkWrap: true,
        itemCount: context.read<FilterRepository>().allFilters.length,
        itemBuilder: (BuildContext context, index) {
          return buildFilterTile(context, index);
        },
      ),
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
