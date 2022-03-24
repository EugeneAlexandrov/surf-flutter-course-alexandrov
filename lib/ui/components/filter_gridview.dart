import 'package:flutter/material.dart';
import 'package:places/domain/model/filter.dart';
import 'package:places/ui/components/filter_tile.dart';

class FilterGridViewWidget extends StatefulWidget {
  const FilterGridViewWidget({
    required this.children,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final ValueChanged<int> onChanged;
  final List<Filter> children;

  @override
  State<FilterGridViewWidget> createState() => _FilterGridViewWidgetState();
}

class _FilterGridViewWidgetState extends State<FilterGridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true,
      itemCount: widget.children.length,
      itemBuilder: (BuildContext context, index) {
        return buildFilterTile(
            context, widget.children[index], widget.onChanged);
      },
    );
  }
}
