import 'package:flutter/material.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/ui/components/search_widget.dart';
import 'package:places/ui/components/sight_card.dart';

//First tab with list of interesting places
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  SightRepository sightRepository = SightRepository();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SearchField(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 26),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: sightRepository.sightList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final sight = sightRepository.sightList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SightCard(sight: sight),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
