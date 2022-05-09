import 'package:flutter/material.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/ui/components/gradient_button.dart';
import 'package:places/ui/components/search_widget.dart';
import 'package:places/ui/components/sight_card.dart';
import 'package:provider/provider.dart';

//First tab with list of interesting places
class SightListScreen extends StatelessWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build method of sightListScreen');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          Column(
            children: [
              const SearchField(),
              Expanded(
                child: Consumer<SightRepository>(
                  builder: (context, sightRepository, child) {
                    print('update SightList');
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 26),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: sightRepository.sights.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SightCard(
                              sightID: sightRepository.sights[index].id),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const Positioned.fill(
            bottom: 16,
            child: Align(
                alignment: Alignment.bottomCenter, child: GradientButton()),
          ),
        ],
      ),
    );
  }
}
