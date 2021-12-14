import 'package:flutter/material.dart';
import 'package:places/themes.dart';

import '../../app_strings.dart';


//Simple AppBar with single Text
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SimpleAppBar(this.title, {Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      alignment: Alignment.center,
      child: Text(
        title,
        style: Themes.subtitle,
      ),
    );
  }
}

//AppBar with Text and TabBar
class TabsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TabsAppBar(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(118);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 40, bottom: 22),
          child: Text(
            title,
            style: Themes.subtitle.copyWith(color: Themes.mainColor),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Themes.cardBackground,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Themes.innactiveBlackColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Themes.secondaryColor),
            tabs: const [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 16, 12),
                child: Text(
                  AppStrings.futureVisitString,
                  style: Themes.smallBold,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 16, 12),
                child: Text(
                  AppStrings.visitedString,
                  style: Themes.smallBold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
