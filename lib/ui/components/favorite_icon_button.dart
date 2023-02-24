import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/place_interactor/place_interactor.dart';
import 'package:places/image_paths.dart';
import 'package:provider/provider.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton(this._sightId, {Key? key}) : super(key: key);

  final int _sightId;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceInteractor>(
      builder: (context, intentionRepository, child) {
        bool pressed = intentionRepository.isFavorite(_sightId);
        return Material(
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            child: IconButton(
                icon: SvgPicture.asset(
                  pressed
                      ? AssetImages.iconHeartFillPath
                      : AssetImages.iconHeartOutlinePath,
                  color: Colors.white,
                  height: 24,
                ),
                onPressed: () {
                  intentionRepository.changeFavoriteState(_sightId);
                }),
          ),
        );
      },
    );
  }
}
