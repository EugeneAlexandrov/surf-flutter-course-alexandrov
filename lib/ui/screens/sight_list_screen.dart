import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_router.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:places/ui/components/custom_icon_button.dart';
import 'package:places/ui/components/gradient_button.dart';
import 'package:places/ui/components/search_widget.dart';
import 'package:places/ui/components/sight_card.dart';
import 'package:places/ui/screens/res/custom_color_scheme.dart';
import 'package:provider/provider.dart';

//First tab with list of interesting places
class SightListScreen extends StatelessWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SightRepository>(
      builder: (context, sightRepository, child) {
        return MediaQuery.of(context).orientation == Orientation.portrait
            ? const _PortraitSightListScreen()
            : const _LandscapeSightListScreen();
      },
    );
  }
}

class _PortraitSightListScreen extends StatelessWidget {
  const _PortraitSightListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[const SearchSliverAppBar()];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            Consumer<SightRepository>(
              builder: (context, sightRepository, child) {
                return _ListPortraitWidget(sightRepository);
              },
            ),
            const Positioned.fill(
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

class _LandscapeSightListScreen extends StatelessWidget {
  const _LandscapeSightListScreen({Key? key}) : super(key: key);

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
          Consumer<SightRepository>(builder: (context, sightRepository, child) {
        return _ListLandscapeWidget(sightRepository);
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
  const _ListLandscapeWidget(this.sightRepository, {Key? key})
      : super(key: key);

  final SightRepository sightRepository;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          itemCount: sightRepository.sights.length,
          itemBuilder: (context, index) {
            return SightCard(sightID: sightRepository.sights[index].id);
          }),
    );
  }
}

class _ListPortraitWidget extends StatelessWidget {
  const _ListPortraitWidget(this.sightRepository, {Key? key}) : super(key: key);

  final SightRepository sightRepository;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: sightRepository.sights.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SightCard(sightID: sightRepository.sights[index].id),
        );
      },
    );
  }
}
