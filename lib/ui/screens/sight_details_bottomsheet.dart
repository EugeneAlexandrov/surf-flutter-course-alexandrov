import 'package:flutter/material.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/ui/screens/sight_details_screen.dart';

class SightDetailsBottomSheet extends StatelessWidget {
  SightDetailsBottomSheet(
      {required this.sight,
      Key? key,
      required this.scrollController,
      required this.context,
      required this.bottomSheetOffset})
      : super(key: key);

  final Sight sight;
  final ScrollController scrollController;
  final BuildContext context;
  final double bottomSheetOffset;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: Colors.white,
          ),
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 384,
                child: sight.images.isEmpty
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
                                    sight.images[index].url,
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: sight.images.length,
                        ),
                      ),
              ),
              DetailsInfo(id: sight.id),
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
