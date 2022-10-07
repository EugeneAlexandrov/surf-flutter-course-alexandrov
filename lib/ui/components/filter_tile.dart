import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/domain/model/filter.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:provider/provider.dart';

Widget buildFilterTile(
  BuildContext _context,
  int index,
) {
  return Consumer<FilterRepository>(
    builder: (_context, FilterRepository filterRepository, child) {
      Filter filter = filterRepository.allFilters[index];
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            filterRepository.changeFilter(filter.id);
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
                      child: filter.isActive
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
                          : Container(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                filter.title,
                textAlign: TextAlign.center,
                style: Theme.of(_context).textTheme.headline1,
                maxLines: 1,
              ),
            ],
          ),
        ),
      );
    },
  );
}
