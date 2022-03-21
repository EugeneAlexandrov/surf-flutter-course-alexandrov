import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_icon_button.dart';
import 'package:places/ui/screens/res/themes.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

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
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppStrings.searchString,
                hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Theme.of(context).colorScheme.smallInnactive),
              ),
            ),
          ),
          const SizedBox(width: 14),
          CustomIconButton(
            child: SvgPicture.asset(AssetImages.iconFilterPath),
            onPressed: () {
              Navigator.of(context).pushNamed('/main_screen/filters');
            },
          ),
        ],
      ),
    );
  }
}
