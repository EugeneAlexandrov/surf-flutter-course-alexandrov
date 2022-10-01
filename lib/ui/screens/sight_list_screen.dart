import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_router.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_icon_button.dart';
import 'package:places/ui/components/gradient_button.dart';
import 'package:places/ui/components/search_widget.dart';
import 'package:places/ui/components/sight_card.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';

//First tab with list of interesting places
class SightListScreen extends StatelessWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[buildSliverAppbar(context)];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            Consumer<SightRepository>(
              builder: (context, sightRepository, child) {
                return ListView.builder(
                  physics: Platform.isAndroid
                      ? const ClampingScrollPhysics()
                      : const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 8),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: sightRepository.sights.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child:
                          SightCard(sightID: sightRepository.sights[index].id),
                    );
                  },
                );
              },
            ),
            const Positioned.fill(
              bottom: 16,
              child: Align(
                  alignment: Alignment.bottomCenter, child: GradientButton()),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppbar(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: theme.colorScheme.lmBackgroundDmMain,
      pinned: true,
      floating: true,
      snap: true,
      expandedHeight: 206,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var top = constraints.biggest.height;
          return FlexibleSpaceBar(
            centerTitle: true,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: top > 0 && top < 100 ? 1.0 : 0.0,
              child: Text(
                AppStrings.appBarTitleIntesestingString,
                style: theme.textTheme.bodyText1,
              ),
            ),
            background: Container(
              height: 206,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 64,
                      left: 16.0,
                      right: 16.0,
                      bottom: 30,
                    ),
                    child: Text(AppStrings.appBarTitleIntesestingString,
                        style: theme.textTheme.headline4?.copyWith(
                            color: theme.colorScheme.title,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 14,
                    ),
                    child: SearchField(
                      iconButton: CustomIconButton(
                        child: SvgPicture.asset(AssetImages.iconFilterPath),
                        onPressed: () {
                          print('textfield tap');
                          Navigator.pushNamed(context, AppRouter.filters);
                        },
                      ),
                      textfield: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppStrings.searchString,
                          hintStyle: theme.textTheme.bodyText1?.copyWith(
                              color: theme.colorScheme.smallInnactive),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
