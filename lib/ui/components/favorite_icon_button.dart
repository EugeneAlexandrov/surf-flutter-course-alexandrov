import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/image_paths.dart';

class FavoriteIconButton extends StatefulWidget {
  const FavoriteIconButton({Key? key}) : super(key: key);

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        child: IconButton(
          icon: SvgPicture.asset(
            _isFavorited
                ? AssetImages.iconHeartFillPath
                : AssetImages.iconHeartOutlinePath,
            color: Colors.white,
            height: 24,
          ),
          onPressed: _toggleFavorite,
        ),
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }
}
