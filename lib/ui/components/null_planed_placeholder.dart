import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screens/res/themes.dart';

class NullPlannedPlaceHolder extends StatelessWidget {
  const NullPlannedPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AssetImages.goPath,
          color: Colors.white,
          height: 64,
        ),
        const SizedBox(height: 24),
        Text(AppStrings.emptyString,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Theme.of(context).colorScheme.subTitle)),
        const SizedBox(height: 8),
        Text(AppStrings.nullPlannedTextString,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: Theme.of(context).colorScheme.smallInnactive)),
      ],
    );
  }
}
