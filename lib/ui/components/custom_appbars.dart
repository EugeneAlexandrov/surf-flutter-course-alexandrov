import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_router.dart';
import 'package:places/data/model/mock_models/place_image.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screens/res/custom_color_scheme.dart';
import 'package:places/ui/screens/res/styles.dart';
import 'package:places/ui/components/custom_icon_button.dart';
import 'package:places/ui/components/search_widget.dart';
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
            ?.copyWith(color: theme.extension<CustomColors>()!.title),
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
    final colors = theme.extension<CustomColors>();
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 40, bottom: 22),
          child: Text(
            title,
            style: theme.textTheme.headline6?.copyWith(color: colors!.title),
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
class ImageAppBar extends StatelessWidget {
  ImageAppBar(this.images, {Key? key}) : super(key: key);

  final PageController pageController = PageController();
  final List<PlaceImage> images;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 360,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            SizedBox(
              height: 384,
              child: images.isEmpty
                  ? Center(
                      child: Text('Изображений объекта нет',
                          style: Theme.of(context).textTheme.headline5),
                    )
                  : Scrollbar(
                      radius: const Radius.circular(12),
                      thickness: 8,
                      controller: pageController,
                      thumbVisibility: true,
                      child: PageView.builder(
                        controller: pageController,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                alignment: Alignment.topCenter,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  images[index].url,
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: images.length,
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
        ),
      ),
    );
  }
}

class SearchSliverAppBar extends StatefulWidget {
  const SearchSliverAppBar({Key? key}) : super(key: key);

  @override
  State<SearchSliverAppBar> createState() => _SearchSliverAppBarState();
}

class _SearchSliverAppBarState extends State<SearchSliverAppBar> {
  bool _showTitle = false;
  final kExpandedHeight = 220.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();

    return SliverAppBar(
      backgroundColor: colors!.lmBackgroundDmMain,
      pinned: true,
      floating: true,
      snap: true,
      expandedHeight: kExpandedHeight,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var top = constraints.biggest.height;
          if (top > 80) {
            _showTitle = false;
          } else {
            _showTitle = true;
          }
          return FlexibleSpaceBar(
            centerTitle: true,
            title: _showTitle
                ? Text(
                    AppStrings.appBarTitleInterestingStringSmall,
                    style: theme.textTheme.bodyText1,
                  )
                : null,
            // centerTitle: true,
            background: Container(
              height: 220,
              padding: const EdgeInsets.only(top: 64),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(AppStrings.appBarTitleInterestingStringLarge,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.headline4?.copyWith(
                            color: colors.title, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 14),
                      child: SearchField(
                          iconButton: CustomIconButton(
                            child: SvgPicture.asset(AssetImages.iconFilterPath),
                            onPressed: () {
                              // navigate to Filters
                              Navigator.pushNamed(context, AppRouter.filters);
                              //
                            },
                          ),
                          textfield: GestureDetector(
                            onTap: () {
                              // navigate to SearchScreen
                              Navigator.pushNamed(
                                  context, AppRouter.searchScreen);
                              //
                            },
                            child: Text(
                              AppStrings.searchString,
                              style: theme.textTheme.bodyText1
                                  ?.copyWith(color: colors.subTitle),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
