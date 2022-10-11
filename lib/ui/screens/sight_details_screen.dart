import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_appbars.dart';
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
            child: DetailsInfo(
              id: sight.id,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsInfo extends StatelessWidget {
  const DetailsInfo({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Consumer2<SightRepository, FilterRepository>(
      builder: (
        context,
        SightRepository sightRepository,
        FilterRepository filterRepository,
        child,
      ) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                sightRepository.getSightById(id).name,
                style: theme.textTheme.headline5,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(children: [
                Text(
                  filterRepository
                      .getFilterById(sightRepository.getSightById(id).filterId)
                      .title,
                  style: theme.textTheme.caption?.copyWith(
                    color: colors!.smallBoldSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  AppStrings.detailsScreenTime,
                  style: theme.textTheme.bodyText2?.copyWith(
                    color: colors!.smallSecondaryTwo,
                  ),
                ),
              ]),
              const SizedBox(height: 24),
              Text(sightRepository.getSightById(id).details,
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
              //placeholder for two buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: null,
                    icon: SvgPicture.asset(
                      AssetImages.iconCalendarPath,
                      color: colors!.subTitle,
                      height: 24,
                    ),
                    label: const Text(AppStrings.detailsScreenPlanButton),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AssetImages.iconHeartOutlinePath,
                      color: colors.subTitle,
                      height: 24,
                    ),
                    label: const Text(AppStrings.detailsScreenFavButton),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
