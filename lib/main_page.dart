import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/image_paths.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:places/ui/screen/res/config.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

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

  int index = 0;

  @override
  void initState() {
    super.initState();
    bottomNavController = TabController(length: appBars.length, vsync: this);
    bottomNavController.addListener(() {
      setState(() {});
    });
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
          appBar: appBars[index],
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: bottomNavController,
              children: [
                const SightListScreen(),
                SightDetails(sight: sights[2]),
                VisitingScreen(intentionsList),
                Container(color: Colors.pink),
              ]),
          floatingActionButton: FloatingActionButton(
            child: const Text(AppStrings.themeChangeString),
            onPressed: currentTheme.togleTheme,
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            onTap: (currentIndex) {
              index = currentIndex;
              bottomNavController.animateTo(currentIndex);
            },
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
