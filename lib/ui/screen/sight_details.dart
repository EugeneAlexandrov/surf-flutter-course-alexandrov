import 'package:flutter/material.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/themes.dart';

class SightDetails extends StatelessWidget {
  SightDetails({Key? key, required this.sight}) : super(key: key);

  Sight sight;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const Galery(),
              DetailsInfo(
                sight: sight,
              )
            ],
          ),
        ),
        Positioned(
          top: 36,
          left: 16,
          child: SizedBox(
            width: 32,
            height: 32,
            child: Container(color: Colors.white),
          ),
        ),
      ]),
    );
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   body: Stack(children: [
    //     SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           const Galery(),
    //           DetailsInfo(
    //             sight: sight,
    //           )
    //         ],
    //       ),
    //     ),
    //     Positioned(
    //       top: 36,
    //       left: 16,
    //       child: SizedBox(
    //         width: 32,
    //         height: 32,
    //         child: Container(color: Colors.white),
    //       ),
    //     ),
    //   ]),
    // );
  }
}

class Galery extends StatelessWidget {
  const Galery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      width: double.infinity,
      color: Colors.green,
    );
  }
}

class DetailsInfo extends StatefulWidget {
  const DetailsInfo({Key? key, required this.sight}) : super(key: key);

  final Sight sight;

  @override
  _DetailsInfoState createState() => _DetailsInfoState();
}

class _DetailsInfoState extends State<DetailsInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.sight.name,
            style: Themes.title,
          ),
          const SizedBox(
            height: 4,
          ),
          Row(children: [
            Text(
              widget.sight.type,
              style: Themes.smallBold,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                AppStrings.detailsScreenTime,
                style: Themes.small.copyWith(color: Themes.secondaryColor2),
              ),
            )
          ]),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(widget.sight.details, style: Themes.small)),
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 24, bottom: 16),
              height: 1,
              color: const Color(0x567C7E92)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(children: [
                const Icon(
                  Icons.calendar_today,
                  size: 24,
                  color: Themes.innactiveBlackColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(AppStrings.detailsScreenPlanButton,
                    style: Themes.small
                        .copyWith(color: Themes.innactiveBlackColor)),
              ]),
              Row(children: const [
                Icon(
                  Icons.favorite_border_rounded,
                  size: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(AppStrings.detailsScreenFavButton),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
