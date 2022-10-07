import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/colors.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.title,
    required this.subTitle,
    required this.smallSecondaryTwo,
    required this.smallBoldSecondary,
    required this.lmBackgroundDmDark,
    required this.lmBackgroundDmMain,
  });
  final Color? title;
  final Color? subTitle;
  final Color? smallSecondaryTwo;
  final Color? smallBoldSecondary;
  final Color? lmBackgroundDmDark;
  final Color? lmBackgroundDmMain;

  @override
  CustomColors copyWith({
    Color? title,
    Color? subTitle,
    Color? smallSecondaryTwo,
    Color? smallBoldSecondary,
    Color? lmBackgroundDmDark,
    Color? lmBackgroundDmMain,
  }) {
    return CustomColors(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      smallSecondaryTwo: smallSecondaryTwo ?? this.smallSecondaryTwo,
      smallBoldSecondary: smallBoldSecondary ?? this.smallBoldSecondary,
      lmBackgroundDmDark: lmBackgroundDmDark ?? this.lmBackgroundDmDark,
      lmBackgroundDmMain: lmBackgroundDmMain ?? this.lmBackgroundDmMain,
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(
      ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      title: Color.lerp(title, other.title, t),
      subTitle: Color.lerp(subTitle, other.subTitle, t),
      smallSecondaryTwo:
          Color.lerp(smallSecondaryTwo, other.smallSecondaryTwo, t),
      smallBoldSecondary:
          Color.lerp(smallBoldSecondary, other.smallBoldSecondary, t),
      lmBackgroundDmDark:
          Color.lerp(lmBackgroundDmDark, other.lmBackgroundDmDark, t),
      lmBackgroundDmMain:
          Color.lerp(lmBackgroundDmMain, other.lmBackgroundDmMain, t),
    );
  }

  static const light = CustomColors(
    title: AppColors.lmMain,
    subTitle: AppColors.lmInnactiveBlack,
    smallSecondaryTwo: AppColors.lmSecondaryTwo,
    smallBoldSecondary: AppColors.lmSecondary,
    lmBackgroundDmDark: AppColors.lmBackground,
    lmBackgroundDmMain: Colors.white,
  );
  // the dark theme
  static const dark = CustomColors(
    title: Colors.white,
    subTitle: AppColors.dmInnactiveBlack,
    smallSecondaryTwo: AppColors.dmSecondaryTwo,
    smallBoldSecondary: AppColors.dmSecondary,
    lmBackgroundDmDark: AppColors.dmDark,
    lmBackgroundDmMain: AppColors.dmMain,
  );
}
