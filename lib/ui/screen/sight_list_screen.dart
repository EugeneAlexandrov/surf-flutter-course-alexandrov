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
      appBar: AppBar(
        toolbarHeight: 112,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(top: 40),
          child: const Text(
            AppStrings.sightListScreenTitle,
            style: Themes.largeTitle,
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
        ),
      ),
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
