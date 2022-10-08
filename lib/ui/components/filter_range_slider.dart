import 'package:flutter/material.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/ui/screens/res/custom_color_scheme.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';

class MyRangeSlider extends StatefulWidget {
  const MyRangeSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<MyRangeSlider> createState() => _MyRangeSliderState();
}

class _MyRangeSliderState extends State<MyRangeSlider> {
  late RangeValues _selectedRange;

  @override
  void initState() {
    super.initState();
    _selectedRange = context.read<FilterRepository>().range;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.distanceString,
              textAlign: TextAlign.start,
              style: theme.textTheme.bodyText1
                  ?.copyWith(color: theme.extension<CustomColors>()!.title),
            ),
            Text(
              'от ${_selectedRange.start} до ${_selectedRange.end} км',
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyText1?.copyWith(
                  color: theme.extension<CustomColors>()!.smallSecondaryTwo),
            )
          ],
        ),
        const SizedBox(height: 10),
        RangeSlider(
          min: 0.1,
          max: 10,
          values: _selectedRange,
          onChangeEnd: (RangeValues newRange) {
            context.read<FilterRepository>().changeRange(_selectedRange);
          },
          onChanged: (RangeValues value) {
            roundToDecimals(value);
            setState(() {});
          },
        )
      ],
    );
  }

  void roundToDecimals(RangeValues oldRange) {
    double start = (oldRange.start * 10).round() / 10;
    double end = (oldRange.end * 10).round() / 10;
    _selectedRange = RangeValues(start, end);
  }
}
