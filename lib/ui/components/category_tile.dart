import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:places/domain/store/places_store.dart';
import 'package:places/ui/res/colors.dart';
import 'package:provider/provider.dart';

class FilterTile extends StatelessWidget {
  const FilterTile(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final store = context.read<PlacesStore>();
    PlaceType filter = store.placeTypes[index];
    log('build run. Filter $index ${filter.title}', name: 'FilterTile');
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          store.changePlaceType(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.lmGreen.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        filter.iconName,
                        color: AppColors.lmGreen,
                        height: 32,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Observer(builder: (context) {
                      return filter.isActive
                          ? Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 20,
                                color: Colors.white,
                              ),
                            )
                          : Container();
                    }),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              filter.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
