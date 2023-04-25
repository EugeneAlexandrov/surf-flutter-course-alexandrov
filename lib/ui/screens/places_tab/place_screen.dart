import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_router.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/place_interactor/place_interactor.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:places/ui/components/custom_icon_button.dart';
import 'package:places/ui/components/gradient_button.dart';
import 'package:places/ui/components/search_widget.dart';
import 'package:places/ui/components/place_card.dart';
import 'package:places/ui/res/custom_color_scheme.dart';
import 'package:provider/provider.dart';

//First tab with list of interesting places
class PlaceTabScreen extends StatelessWidget {
  const PlaceTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? const _PortraitPlaceListScreen()
        : const _LandscapePlaceListScreen();
  }
}

class _PortraitPlaceListScreen extends StatelessWidget {
  const _PortraitPlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[const SearchSliverAppBar()];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: const [
            _ListPortraitWidget(),
            Positioned.fill(
              bottom: 16,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GradientButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LandscapePlaceListScreen extends StatelessWidget {
  const _LandscapePlaceListScreen({Key? key}) : super(key: key);

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

class _ListPortraitWidget extends StatelessWidget {
  const _ListPortraitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build Widget');
    final places = Provider.of<PlaceInteractor>(context, listen: false).places;
    return StreamBuilder(
      initialData: places,
      stream: Provider.of<PlaceInteractor>(context, listen: false).getPlaces(),
      builder: (context, snapshot) {
        print('Snapshot ${snapshot.data}');
        print('Connection ${snapshot.connectionState}');

        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            // return const LinearProgressIndicator();
          case ConnectionState.active:
            if ((snapshot.data as List<Place>).isEmpty) {
              return const Center(child: Text('Нет данных'));
            }
            final places = snapshot.data as List<Place>;
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: places.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: PlaceCard(place: places[index]),
                );
              },
            );
          case ConnectionState.none:
            return const Center(child: Text('Нет данных'));
          case ConnectionState.done:
            return Center(child: Text('232'));
        }
      },
    );
  }
}
