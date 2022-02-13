import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/sight_card.dart';

//First tab with list of interesting places
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: sights.map((sight) => SightCard(sight: sight)).toList(),
      ),
    );
  }
}
