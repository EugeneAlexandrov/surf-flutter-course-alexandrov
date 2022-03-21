import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        ListTile(
          title: const Text(AppStrings.darkThemeString),
          trailing: Consumer<CustomTheme>(
            builder: (context, CustomTheme theme, child) {
              return CupertinoSwitch(
                value: theme.isDark,
                onChanged: (newValue) {
                  theme.changeTheme(newValue);
                },
              );
            },
          ),
        ),
        ListTile(
          title: const Text(AppStrings.showTutorialString),
          trailing: SvgPicture.asset(AssetImages.iconInfoPath),
        ),
      ]).toList(),
    );
  }
}
