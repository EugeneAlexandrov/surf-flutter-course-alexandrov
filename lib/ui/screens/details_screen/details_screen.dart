import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:places/app_strings.dart';
import 'package:places/data/mock_filters.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/place_interactor/place_interactor.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/custom_color_scheme.dart';
import 'package:provider/provider.dart';

//Screen with sight card details
class DetailsScreen extends StatelessWidget {
  const DetailsScreen(this.place, {Key? key}) : super(key: key);
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ImageAppBar(place.urls),
          SliverToBoxAdapter(
            child: DetailsInfo(place),
          ),
        ],
      ),
    );
  }
}

class DetailsInfo extends StatelessWidget {
  const DetailsInfo(this.place, {Key? key}) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();

    final placeInteractor =
        Provider.of<PlaceInteractor>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // name
          Text(
            place.name,
            style: theme.textTheme.headline5,
          ),
          const SizedBox(height: 4),
          Row(children: [
            //filter title
            Text(
              getFilterTitle(place.placeType),
              style: theme.textTheme.caption?.copyWith(
                color: colors!.smallBoldSecondary,
              ),
            ),
            const SizedBox(width: 16),
            // time
            Text(
              AppStrings.detailsScreenTime,
              style: theme.textTheme.bodyText2?.copyWith(
                color: colors!.smallSecondaryTwo,
              ),
            ),
          ]),
          const SizedBox(height: 24),
          // details
          Text(place.description, style: theme.textTheme.bodyText2),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {},
            icon: SvgPicture.asset(AssetImages.iconGoPath),
            label: const Text(AppStrings.buildPathString),
          ),
          const SizedBox(height: 24),
          Container(
            height: 0.8,
            color: const Color.fromRGBO(124, 126, 146, 0.24),
          ),
          const SizedBox(height: 8),
          //for two buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              placeInteractor.findIntentionByPlaceId(place.id).hasVisited
                  ? const _VisitedButton()
                  : _PlannedButton(place),
              _FavoriteButton(place),
            ],
          ),
        ],
      ),
    );
  }
}

void changeDate(BuildContext context, int id) async {
  var date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(
      const Duration(days: 365),
    ),
  );
  if (date != null) {
    Provider.of<PlaceInteractor>(context, listen: false).changeDate(date, id);
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton(this.place, {Key? key}) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Consumer<PlaceInteractor>(
      builder: (context, placeInteractor, child) {
        final PlaceInteractor placeInteractor =
            Provider.of<PlaceInteractor>(context, listen: false);
        bool pressed = placeInteractor.isFavorite(place.id);
        return TextButton.icon(
          icon: SvgPicture.asset(
            pressed
                ? AssetImages.iconHeartFillPath
                : AssetImages.iconHeartOutlinePath,
            height: 24,
            color: colors!.title,
          ),
          onPressed: () {
            placeInteractor.changeFavoriteState(place.id);
          },
          label: const Text(AppStrings.detailsScreenFavButton),
        );
      },
    );
  }
}

class _PlannedButton extends StatelessWidget {
  const _PlannedButton(this.place, {Key? key}) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    final PlaceInteractor placeInteractor =
        Provider.of<PlaceInteractor>(context, listen: false);
    String plannedButtonText = AppStrings.detailsScreenPlanButton;
    DateTime? date = placeInteractor.findIntentionByPlaceId(place.id).date;
    if (date != null) {
      final DateFormat formatter = DateFormat('yyyy-MMM-dd');
      plannedButtonText = formatter.format(date);
    }
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();

    return TextButton.icon(
      onPressed: placeInteractor.isFavorite(place.id)
          ? () {
              changeDate(context, place.id);
            }
          : null,
      icon: SvgPicture.asset(
        AssetImages.iconCalendarPath,
        color: placeInteractor.findIntentionByPlaceId(place.id).date != null
            ? AppColors.lmGreen
            : colors!.title,
        height: 24,
      ),
      label: Text(
        plannedButtonText,
        style: theme.textTheme.bodyText2?.copyWith(
            color: placeInteractor.findIntentionByPlaceId(place.id).date != null
                ? AppColors.lmGreen
                : colors!.title),
      ),
    );
  }
}

class _VisitedButton extends StatelessWidget {
  const _VisitedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(
        Icons.share_outlined,
        color: colors!.title,
      ),
      label: Text(
        AppStrings.detailsScreenShareButton,
        style: theme.textTheme.bodyText2?.copyWith(color: colors.title),
      ),
    );
  }
}
