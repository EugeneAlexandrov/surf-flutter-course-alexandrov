import 'package:flutter/material.dart';
import 'package:places/styles.dart';
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
        style: Theme.of(context).textTheme.headline6,
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
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            tabBarTheme: Theme.of(context).tabBarTheme,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: const TabBar(
              tabs: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 12),
                  child: Text(
                    AppStrings.futureVisitString,
                    style: smallBold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 12),
                  child: Text(
                    AppStrings.visitedString,
                    style: smallBold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
