import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screens/favorite_tab/favorite_tab_screen.dart';
import 'package:places/ui/screens/map_tab/map_tab_screen.dart';
import 'package:places/ui/screens/places_tab/place_screen.dart';
import 'package:places/ui/screens/settings_tab/settings_screen.dart';

//Main page with BottomNavigationBar
class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController bottomNavController;

  List<Widget> bottomNavTabs = [
    const PlaceTabScreen(),
    const MapTabScreen(),
    const FavoriteTabScreen(),
    const SettingsTabScreen(),
  ];

  @override
  void initState() {
    super.initState();
    bottomNavController =
        TabController(length: bottomNavTabs.length, vsync: this);
    bottomNavController.addListener(() {
      setState(() {});
    });
  }

  void onSelectTab(int index) {
    bottomNavController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: bottomNavController,
              children: bottomNavTabs),
        ),
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
                color: theme.iconTheme.color,
              ),
              icon: SvgPicture.asset(
                AssetImages.iconListOutlinePath,
                color: theme.iconTheme.color,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                AssetImages.iconMapFillPath,
                color: theme.iconTheme.color,
              ),
              icon: SvgPicture.asset(
                AssetImages.iconMapOutlinePath,
                color: theme.iconTheme.color,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                AssetImages.iconHeartFillPath,
                color: theme.iconTheme.color,
              ),
              icon: SvgPicture.asset(
                AssetImages.iconHeartOutlinePath,
                color: theme.iconTheme.color,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                AssetImages.iconSettingsFillPath,
                color: theme.iconTheme.color,
              ),
              icon: SvgPicture.asset(
                AssetImages.iconSettingsOutlinePath,
                color: theme.iconTheme.color,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
