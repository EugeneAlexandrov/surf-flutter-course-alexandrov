import 'package:flutter/material.dart';
import 'package:places/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/themes.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(height: 200),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: sights.map((sight) => SightCard(sight: sight)).toList(),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({Key? key, required this.height}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 64, left: 16),
      child: const Text(
        AppStrings.sightListScreenTitle,
        style: Themes.largeTitle,
      ),
    );
  }
}
