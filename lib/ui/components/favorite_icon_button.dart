import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/repository/intention_repository/intention_reposotory.dart';
import 'package:places/domain/bloc/favotite_bloc/favorite_bloc.dart';
import 'package:places/domain/bloc/favotite_bloc/favorite_event.dart';
import 'package:places/domain/bloc/favotite_bloc/favorite_state.dart';
import 'package:places/domain/model/intention.dart';
import 'package:places/image_paths.dart';
import 'package:provider/provider.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton(this._placeId, {Key? key}) : super(key: key);

  final int _placeId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        final _intention =
            Provider.of<IntentionRepository>(context, listen: false)
                .findIntentionById(_placeId);
        bool _pressed = _intention.placeId == -1;
        return Material(
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            child: IconButton(
                icon: SvgPicture.asset(
                  _pressed
                      ? AssetImages.iconHeartOutlinePath
                      : AssetImages.iconHeartFillPath,
                  color: Colors.white,
                  height: 24,
                ),
                onPressed: () {
                  _pressed
                      ? BlocProvider.of<FavoriteBloc>(context)
                          .add(AddToFavoriteEvent(Intention.empty(_placeId)))
                      : BlocProvider.of<FavoriteBloc>(context)
                          .add(RemoveFromFavoriteEvent(_intention));
                }),
          ),
        );
      },
    );
  }
}
