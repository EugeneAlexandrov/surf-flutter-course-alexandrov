import 'package:flutter/material.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/repository/filter_repository.dart';
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
    // TODO: implement initState
    super.initState();
    _selectedRange = context.read<FilterRepository>().range;
  }

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
              'от ${_selectedRange.start} до ${_selectedRange.end} км',
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
          values: _selectedRange,
          onChangeEnd: (RangeValues newRange) {
            print(
                'onChangeEnd ${_selectedRange.start} - ${_selectedRange.end} _selectedRange: ${_selectedRange.start} - ${_selectedRange.end}');
            context.read<FilterRepository>().changeRange(_selectedRange);
          },
          onChanged: (RangeValues value) {
            print(
                'onChange ${value.start} - ${value.end} _selectedRange: ${_selectedRange.start} - ${_selectedRange.end}');
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
