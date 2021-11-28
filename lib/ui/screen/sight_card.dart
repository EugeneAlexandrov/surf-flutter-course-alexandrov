import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/themes.dart';

class SightCard extends StatelessWidget {
  const SightCard({required Sight sight, Key? key})
      : _sight = sight,
        super(key: key);

  final Sight _sight;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8),
      color: Themes.cardBackground,
      elevation: 0,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                height: 96,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(_sight.name, style: Themes.text),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
                child: Text(_sight.details,
                    style:
                        Themes.small.copyWith(color: Themes.secondaryColor2)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Text(_sight.type,
                          style:
                              Themes.smallBold.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
                const Icon(
                  Icons.favorite_border_outlined,
                  size: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
