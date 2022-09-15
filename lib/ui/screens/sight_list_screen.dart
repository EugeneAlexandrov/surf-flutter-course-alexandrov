import 'dart:io';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          Column(
            children: [
              SearchField(
                iconButton: CustomIconButton(
                  child: SvgPicture.asset(AssetImages.iconFilterPath),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.filters);
                  },
                ),
                textfield: TextField(
                  readOnly: true,
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.searchScreen);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: AppStrings.searchString,
                    hintStyle: theme.textTheme.bodyText1
                        ?.copyWith(color: theme.colorScheme.smallInnactive),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<SightRepository>(
                  builder: (context, sightRepository, child) {
                    return ListView.builder(
                      physics: Platform.isAndroid
                          ? const ClampingScrollPhysics()
                          : const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 26),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: sightRepository.sights.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SightCard(
                              sightID: sightRepository.sights[index].id),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const Positioned.fill(
            bottom: 16,
            child: Align(
                alignment: Alignment.bottomCenter, child: GradientButton()),
          ),
        ],
      ),
    );
  }
}
