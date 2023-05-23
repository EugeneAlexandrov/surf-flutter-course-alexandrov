import 'package:flutter/material.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/store/places_store.dart';
import 'package:places/ui/res/custom_color_scheme.dart';
import 'package:provider/provider.dart';

class MyRangeSlider extends StatefulWidget {
  const MyRangeSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<MyRangeSlider> createState() => _MyRangeSliderState();
}

class _MyRangeSliderState extends State<MyRangeSlider> {
  late double _selectedRadius;

  @override
  void initState() {
    super.initState();
    _selectedRadius = context.read<PlacesStore>().radius;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.distanceString,
              textAlign: TextAlign.start,
              style: theme.textTheme.bodyText1?.copyWith(color: colors!.title),
            ),
            Text(
              '$_selectedRadius км',
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyText1
                  ?.copyWith(color: colors!.smallSecondaryTwo),
            )
          ],
        ),
        const SizedBox(height: 10),
        Slider(
          min: 0.1,
          max: 10.0,
          value: _selectedRadius,
          onChangeEnd: (double newValue) {
            context.read<PlacesStore>().changeRange(_selectedRadius * 1000);
          },
          onChanged: (double value) {
            roundToDecimals(value);
            setState(() {});
          },
        )
      ],
    );
  }

  void roundToDecimals(double value) {
    double radius = (value * 10).round() / 10;
    _selectedRadius = radius;
  }
}
