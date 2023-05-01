import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_router.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/place_interactor/place_interactor.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_icon_button.dart';
import 'package:places/ui/components/place_card.dart';
import 'package:places/ui/components/search_widget.dart';
import 'package:places/ui/res/custom_color_scheme.dart';
import 'package:provider/provider.dart';

class LandscapePlaceListScreen extends StatelessWidget {
  const LandscapePlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(AppStrings.appBarTitleInterestingStringSmall,
            textAlign: TextAlign.left,
            style: theme.textTheme.headline6
                ?.copyWith(color: colors?.title, fontWeight: FontWeight.bold)),
        bottom: const _BottomWidget(),
      ),
      body:
          Consumer<PlaceInteractor>(builder: (context, placeInteractor, child) {
        return _ListLandscapeWidget(placeInteractor);
      }),
    );
  }
}

class _BottomWidget extends StatelessWidget implements PreferredSizeWidget {
  const _BottomWidget({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
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
              Navigator.pushNamed(context, AppRouter.searchScreen);
              //
            },
            child: Text(
              AppStrings.searchString,
              style:
                  theme.textTheme.bodyText1?.copyWith(color: colors?.subTitle),
            ),
          )),
    );
  }
}

class _ListLandscapeWidget extends StatelessWidget {
  const _ListLandscapeWidget(this.placeInteractor, {Key? key})
      : super(key: key);

  final PlaceInteractor placeInteractor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          itemCount: placeInteractor.places.length,
          itemBuilder: (context, index) {
            return PlaceCard(place: placeInteractor.places[index]);
          }),
    );
  }
}
