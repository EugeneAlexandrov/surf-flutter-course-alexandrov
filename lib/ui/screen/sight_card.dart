import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

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
      color: const Color(0xfff5f5f5),
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
                child: Text(_sight.name,
/*
Не понимаю как работает подгрузка шрифтов. В pubspec добавлял
    - asset: res/fonts/Roboto-Bold.ttf
      weight: 700
Шрифты все-равно отличаются от макета 
*/
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1.25,
                        color: Color(0xff3b3e5b))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
                child: Text(_sight.details,
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.25,
                        color: Color(0xff7C7E92))),
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
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
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
