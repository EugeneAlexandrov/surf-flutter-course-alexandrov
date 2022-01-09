import 'package:flutter/material.dart';
import 'package:places/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

import 'colors.dart';

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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBars[index],
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: bottomNavController,
            children: [
              const SightListScreen(),
              Container(color: Colors.red),
              VisitingScreen(intentionsList),
              Container(color: Colors.pink),
            ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (currentIndex) {
            index = currentIndex;
            bottomNavController.animateTo(currentIndex);
          },
          unselectedItemColor: innactiveBlackColor,
          selectedItemColor: mainColor,
          currentIndex: bottomNavController.index,
          items: const [
            BottomNavigationBarItem(
              activeIcon:
                  ImageIcon(ExactAssetImage(AppStrings.iconMapFillPath)),
              icon: ImageIcon(ExactAssetImage(AppStrings.iconListOutlinePath)),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon:
                  ImageIcon(ExactAssetImage(AppStrings.iconMapFillPath)),
              icon: ImageIcon(ExactAssetImage(AppStrings.iconMapOutlinePath)),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon:
                  ImageIcon(ExactAssetImage(AppStrings.iconHeartFillPath)),
              icon: ImageIcon(ExactAssetImage(AppStrings.iconHeartOutlinePath)),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon:
                  ImageIcon(ExactAssetImage(AppStrings.iconSettingsFillPath)),
              icon: ImageIcon(
                  ExactAssetImage(AppStrings.iconSettingsOutlinePath)),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
