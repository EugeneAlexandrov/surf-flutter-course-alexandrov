import 'package:flutter/material.dart';
import 'package:places/app_strings.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screens/res/themes.dart';

class NullVisitedPlaceHolder extends StatelessWidget {
  const NullVisitedPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AssetImages.emptyVisitedImagePath, height: 64),
        const SizedBox(height: 24),
        Text(AppStrings.emptyString,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Theme.of(context).colorScheme.subTitle)),
        const SizedBox(height: 8),
        Text(AppStrings.nullVisitedTextString,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: Theme.of(context).colorScheme.smallInnactive)),
      ],
    );
  }
}
