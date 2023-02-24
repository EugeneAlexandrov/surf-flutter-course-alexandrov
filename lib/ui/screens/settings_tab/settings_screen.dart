import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/settings_interactor/settings_interactor.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:provider/provider.dart';

class SettingsTabScreen extends StatelessWidget {
  const SettingsTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(AppStrings.appBarTitlrSettingsString),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            title: const Text(AppStrings.darkThemeString),
            trailing: Consumer<SettingsInteractor>(
              builder: (context, settingsInteractor, child) {
                return CupertinoSwitch(
                  value: settingsInteractor.isDark,
                  onChanged: (newValue) {
                    settingsInteractor.changeTheme(newValue);
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
      ),
    );
  }
}
