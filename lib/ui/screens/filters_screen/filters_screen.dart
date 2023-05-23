import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/store/places_store.dart';
import 'package:places/ui/components/category_lisrview.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/category_gridview.dart';
import 'package:places/ui/components/category_range_slider.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/custom_color_scheme.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final store = context.read<PlacesStore>();
    final colors = theme.extension<CustomColors>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              store.resetPlaceTypes();
            },
            child: Text(
              AppStrings.cleanFiltersString,
              style:
                  theme.textTheme.bodyText1?.copyWith(color: AppColors.lmGreen),
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
              color: colors!.title,
              height: 32,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 24),
              child: Text(AppStrings.categoriesString.toUpperCase(),
                  style: theme.textTheme.headline1
                      ?.copyWith(color: colors.subTitle)),
            ),
            window.physicalSize.width <= 480
                ? const SizedBox(
                    width: 108, height: 108, child: FilterListViewWidget())
                : const FilterGridViewWidget(),
            const SizedBox(height: 30),
            const MyRangeSlider(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Observer(builder: (context) {
                      log('elevatedButton observer run', name: 'FilterScreen');
                      final isPlaceListEmpty =
                          store.getPlacesFuture?.value?.isEmpty ?? true;
                      log('${store.getPlacesFuture?.value?.isEmpty}',
                          name: 'FilterScreen button visibility');
                      return ElevatedButton(
                        child: store.getPlacesFuture?.status ==
                                FutureStatus.pending
                            ? const CircularProgressIndicator()
                            : Text(
                                '${AppStrings.showString} ${store.getPlacesFuture?.value?.length ?? 0}'),
                        onPressed: isPlaceListEmpty
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                      );
                    }),
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
