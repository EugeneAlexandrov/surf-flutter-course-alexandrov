import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {required this.child, required this.onPressed, Key? key})
      : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      shape: const CircleBorder(),
      child: IconButton(
        icon: child,
        onPressed: onPressed,
      ),
    );
  }
}
