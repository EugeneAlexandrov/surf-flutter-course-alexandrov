import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/image_paths.dart';
import 'package:places/styles.dart';
import 'package:places/ui/screens/res/themes.dart';
import '../../app_strings.dart';

//Simple AppBar with single Text
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SimpleAppBar(this.title, {Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      alignment: Alignment.center,
      child: Text(
        title,
        style: theme.textTheme.headline6
            ?.copyWith(color: theme.colorScheme.lmMainDmWhite),
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
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 40, bottom: 22),
          child: Text(
            title,
            style: theme.textTheme.headline6
                ?.copyWith(color: theme.colorScheme.lmMainDmWhite),
          ),
        ),
        Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            tabBarTheme: theme.tabBarTheme,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
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

//AppBar for details screen with image
class ImageAppBar extends StatelessWidget implements PreferredSizeWidget {
  ImageAppBar({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Size get preferredSize => const Size.fromHeight(361);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 360,
          child: Scrollbar(
            radius: Radius.circular(12),
            thickness: 8,
            controller: pageController,
            thumbVisibility: true,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) {
                return Container(
                    color: index % 2 == 0 ? Colors.green : Colors.red);
              },
              itemCount: 4,
            ),
          ),
        ),
        Positioned(
          top: 36,
          left: 16,
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: SvgPicture.asset(
                AssetImages.iconAppbarArrowPath,
                color: Colors.black,
                height: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
