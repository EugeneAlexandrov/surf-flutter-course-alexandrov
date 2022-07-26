import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screens/res/themes.dart';

class NullPlannedPlaceHolder extends StatelessWidget {
  const NullPlannedPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AssetImages.iconGoPath,
          color: Colors.white,
          height: 64,
        ),
        const SizedBox(height: 24),
        Text(
          AppStrings.emptyString,
          style: theme.textTheme.headline6
              ?.copyWith(color: theme.colorScheme.subTitle),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.nullPlannedTextString,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText2
              ?.copyWith(color: theme.colorScheme.smallInnactive),
        ),
      ],
    );
  }
}
