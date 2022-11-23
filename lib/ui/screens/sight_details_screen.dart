import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/domain/repository/intention_repository.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/custom_color_scheme.dart';
import 'package:provider/provider.dart';

//Screen with sight card details
class SightDetailsScreen extends StatelessWidget {
  const SightDetailsScreen(this.sight, {Key? key}) : super(key: key);
  final Sight sight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ImageAppBar(sight.images),
          SliverToBoxAdapter(
            child: DetailsInfo(sight.id),
          ),
        ],
      ),
    );
  }
}

class DetailsInfo extends StatelessWidget {
  const DetailsInfo(this._sightId, {Key? key}) : super(key: key);

  final int _sightId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();

    final sightRepository =
        Provider.of<SightRepository>(context, listen: false);
    final filterRepository =
        Provider.of<FilterRepository>(context, listen: false);
    final intentionRepository = Provider.of<IntentionRepository>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // name
          Text(
            sightRepository.getSightById(_sightId).name,
            style: theme.textTheme.headline5,
          ),
          const SizedBox(height: 4),
          Row(children: [
            //filter title
            Text(
              filterRepository
                  .getFilterById(
                      sightRepository.getSightById(_sightId).filterId)
                  .title,
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
          Text(sightRepository.getSightById(_sightId).details,
              style: theme.textTheme.bodyText2),
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
              intentionRepository.findIntentionBySightId(_sightId).hasVisited
                  ? const _VisitedButton()
                  : _PlannedButton(_sightId,
                      intentionRepository: intentionRepository),
              _FavoriteButton(_sightId,
                  intentionRepository: intentionRepository),
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
    Provider.of<IntentionRepository>(context, listen: false)
        .changeDate(date, id);
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton(this._sightId,
      {required this.intentionRepository, Key? key})
      : super(key: key);

  final int _sightId;
  final IntentionRepository intentionRepository;

  @override
  Widget build(BuildContext context) {
    bool pressed = intentionRepository.isFavorite(_sightId);
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return TextButton.icon(
      icon: SvgPicture.asset(
        pressed
            ? AssetImages.iconHeartFillPath
            : AssetImages.iconHeartOutlinePath,
        height: 24,
        color: colors!.title,
      ),
      onPressed: () {
        intentionRepository.changeFavoriteState(_sightId);
      },
      label: const Text(AppStrings.detailsScreenFavButton),
    );
  }
}

class _PlannedButton extends StatelessWidget {
  const _PlannedButton(this._sightId,
      {required this.intentionRepository, Key? key})
      : super(key: key);

  final int _sightId;
  final IntentionRepository intentionRepository;

  @override
  Widget build(BuildContext context) {
    String plannedButtonText = AppStrings.detailsScreenPlanButton;
    DateTime? date = intentionRepository.findIntentionBySightId(_sightId).date;
    if (date != null) {
      final DateFormat formatter = DateFormat('yyyy-MMM-dd');
      plannedButtonText = formatter.format(date);
    }
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();

    return TextButton.icon(
      onPressed: intentionRepository.isFavorite(_sightId)
          ? () {
              changeDate(context, _sightId);
            }
          : null,
      icon: SvgPicture.asset(
        AssetImages.iconCalendarPath,
        color: intentionRepository.findIntentionBySightId(_sightId).date != null
            ? AppColors.lmGreen
            : colors!.title,
        height: 24,
      ),
      label: Text(
        plannedButtonText,
        style: theme.textTheme.bodyText2?.copyWith(
            color: intentionRepository.findIntentionBySightId(_sightId).date !=
                    null
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
