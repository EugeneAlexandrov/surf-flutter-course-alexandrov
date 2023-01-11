import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/res/custom_color_scheme.dart';
import 'package:places/ui/screens/details_screen/details_screen.dart';

class DetailsBottomSheet extends StatelessWidget {
  DetailsBottomSheet(
      {required this.place,
      Key? key,
      required this.scrollController,
      required this.context,
      required this.bottomSheetOffset})
      : super(key: key);

  final Place place;
  final ScrollController scrollController;
  final BuildContext context;
  final double bottomSheetOffset;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: colors!.lmBackgroundDmMain,
          ),
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 384,
                child: place.urls.isEmpty
                    ? Center(
                        child: Text('Изображений объекта нет',
                            style: Theme.of(context).textTheme.headline5),
                      )
                    : Scrollbar(
                        radius: const Radius.circular(12),
                        thickness: 8,
                        controller: pageController,
                        thumbVisibility: true,
                        child: PageView.builder(
                          controller: pageController,
                          itemBuilder: (context, index) {
                            return Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    place.urls[index],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: place.urls.length,
                        ),
                      ),
              ),
              DetailsInfo(place),
            ],
          ),
        ),
        Positioned(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.cancel,
              color: Colors.white,
              size: 40,
            ),
          ),
          top: 16,
          right: 16,
        ),
        Positioned.fill(
          top: 12,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 4,
              width: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
