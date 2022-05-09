import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/themes.dart';

class MyInputField extends StatelessWidget {
  const MyInputField({required this.child, required this.title, Key? key})
      : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: Theme.of(context).colorScheme.subTitle)),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
