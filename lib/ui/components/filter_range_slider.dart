import 'package:flutter/material.dart';
import 'package:places/app_strings.dart';
import 'package:places/ui/screens/res/themes.dart';

class MyRangeSlider extends StatefulWidget {
  const MyRangeSlider({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final void Function(RangeValues range) onChanged;

  @override
  State<MyRangeSlider> createState() => _MyRangeSliderState();
}

class _MyRangeSliderState extends State<MyRangeSlider> {
  var selectedRange = const RangeValues(0.5, 5);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.distanceString,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.lmMainDmWhite),
            ),
            Text(
              'от ${selectedRange.start} до ${selectedRange.end} км',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.smallSecondaryTwo),
            )
          ],
        ),
        const SizedBox(height: 10),
        RangeSlider(
          min: 0.1,
          max: 10,
          values: selectedRange,
          onChangeEnd: (RangeValues newRange) {
            print('${selectedRange.start} - ${selectedRange.end}');
            widget.onChanged(newRange);
          },
          onChanged: (RangeValues value) {
            setState(
              () {
                selectedRange = roundToDecimals(value);
              },
            );
          },
        )
      ],
    );
  }

  RangeValues roundToDecimals(RangeValues oldRange) {
    double start = (oldRange.start * 10).round() / 10;
    double end = (oldRange.end * 10).round() / 10;
    return RangeValues(start, end);
  }
}
