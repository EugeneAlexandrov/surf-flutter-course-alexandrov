import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/data/mock_intentions.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';

//Main page with BottomNavigationBar
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController bottomNavController;

  List<PreferredSizeWidget> appBars = [
    const SimpleAppBar(AppStrings.appBarTitleIntesestingString),
    const SimpleAppBar(AppStrings.appBarTitleMapString),
    const TabsAppBar(AppStrings.appBarTitleFavoriteString),
    const SimpleAppBar(AppStrings.appBarTitlrSettingsString),
  ];

  List<Widget> bottomNavTabs = [
    const SightListScreen(),
    Container(color: Colors.red),
    VisitingScreen(mockIntentionsList),
    const SettingsScreen(),
  ];

  int _index = 0;

  @override
  void initState() {
    super.initState();
    bottomNavController = TabController(length: appBars.length, vsync: this);
    bottomNavController.addListener(() {
      setState(() {});
    });
  }

  void onSelectTab(int index) {
    _index = index;
    bottomNavController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: Platform.isIOS
            ? SystemUiOverlayStyle.dark
            : const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
              ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBars[_index],
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: bottomNavController,
              children: bottomNavTabs),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            onTap: onSelectTab,
            currentIndex: bottomNavController.index,
            items: [
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AssetImages.iconListFillPath,
                  color: Theme.of(context).iconTheme.color,
                ),
                icon: SvgPicture.asset(
                  AssetImages.iconListOutlinePath,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AssetImages.iconMapFillPath,
                  color: Theme.of(context).iconTheme.color,
                ),
                icon: SvgPicture.asset(
                  AssetImages.iconMapOutlinePath,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AssetImages.iconHeartFillPath,
                  color: Theme.of(context).iconTheme.color,
                ),
                icon: SvgPicture.asset(
                  AssetImages.iconHeartOutlinePath,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AssetImages.iconSettingsFillPath,
                  color: Theme.of(context).iconTheme.color,
                ),
                icon: SvgPicture.asset(
                  AssetImages.iconSettingsOutlinePath,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
