import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screens/res/themes.dart';

class SearchField extends StatelessWidget {
  const SearchField(
      {required this.iconButton, required this.textfield, Key? key})
      : super(key: key);

  final Widget iconButton;
  final Widget textfield;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.lmBackgroundDmDark,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(AssetImages.iconSearchPath),
          const SizedBox(width: 14),
          Expanded(
            child: textfield,
          ),
          const SizedBox(width: 14),
          iconButton,
        ],
      ),
    );
  }
}
