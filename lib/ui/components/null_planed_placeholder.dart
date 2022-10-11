import 'package:flutter/material.dart';
import 'package:places/app_strings.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screens/res/custom_color_scheme.dart';

class NullPlannedPlaceHolder extends StatelessWidget {
  const NullPlannedPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AssetImages.emptyVisitedImagePath, height: 64),
        const SizedBox(height: 24),
        Text(
          AppStrings.emptyString,
          style: theme.textTheme.headline6?.copyWith(color: colors!.subTitle),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.nullPlannedTextString,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText2?.copyWith(color: colors!.subTitle),
        ),
      ],
    );
  }
}
