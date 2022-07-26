import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/colors.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/filter_gridview.dart';
import 'package:places/ui/components/filter_range_slider.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer2<SightRepository, FilterRepository>(
      builder: (context, sightRepository, filterRepository, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              TextButton(
                onPressed: () {
                  filterRepository.resetFilters();
                },
                child: Text(
                  AppStrings.cleanFiltersString,
                  style: theme.textTheme.bodyText1
                      ?.copyWith(color: AppColors.lmGreen),
                ),
              ),
            ],
            leading: Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  AssetImages.iconAppbarArrowPath,
                  color: theme.colorScheme.title,
                  height: 32,
                ),
              ),
            ),
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24),
                    child: Text(AppStrings.categoriesString.toUpperCase(),
                        style: theme.textTheme.headline1
                            ?.copyWith(color: theme.colorScheme.subTitle)),
                  ),
                  const FilterGridViewWidget(),
                  const SizedBox(height: 30),
                  const MyRangeSlider(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text(
                                '${AppStrings.showString} (${sightRepository.sights.length})'),
                            onPressed: sightRepository.sights.isEmpty
                                ? null
                                : () {
                                    Navigator.pop(context);
                                  },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
