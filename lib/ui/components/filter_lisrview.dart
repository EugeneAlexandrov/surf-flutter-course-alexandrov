import 'package:flutter/material.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/ui/components/filter_tile.dart';
import 'package:provider/provider.dart';

class FilterListViewWidget extends StatelessWidget {
  const FilterListViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: context.read<FilterRepository>().allFilters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              width: 100,
              child: FilterTile(index),
            ),
          );
        });
  }
}
