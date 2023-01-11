import 'package:flutter/material.dart';
import 'package:places/ui/res/custom_color_scheme.dart';

class MyInputField extends StatelessWidget {
  const MyInputField({required this.child, required this.title, Key? key})
      : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: theme.textTheme.headline1
              ?.copyWith(color: theme.extension<CustomColors>()!.subTitle),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
