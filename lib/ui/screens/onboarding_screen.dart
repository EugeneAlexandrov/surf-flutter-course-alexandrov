import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/image_paths.dart';
import 'package:places/main.dart';
import 'package:places/main_page.dart';
import 'package:places/ui/screens/res/themes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  var _index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: _index == 2 ? false : true,
              child: TextButton(
                  onPressed: () {
                    controller.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(
                    'Пропустить',
                    style: theme.textTheme.bodyText1
                        ?.copyWith(color: AppColors.lmGreen),
                  )),
            )
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                _index = index;
                setState(() {});
              },
              children: const [
                MyPage(
                  title: AppStrings.onBoardingTitleOne,
                  subtitle: AppStrings.onBoardingSubtitleOne,
                  imagePath: AssetImages.iconOnboardingOnePath,
                ),
                MyPage(
                  title: AppStrings.onBoardingTitleTwo,
                  subtitle: AppStrings.onBoardingSubtitleTwo,
                  imagePath: AssetImages.iconOnboardingTwoPath,
                ),
                MyPage(
                  title: AppStrings.onBoardingTitleThree,
                  subtitle: AppStrings.onBoardingSubtitleThree,
                  imagePath: AssetImages.iconOnboardingThreePath,
                ),
              ],
              controller: controller,
            ),
          ),
          Indicator(index: _index),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: _index == 2 ? true : false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      OnBoardindShowProvider.read(context)?.endShow();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MainPage()),
                          (route) => false);
                    },
                    child: const Text(AppStrings.onBoardingStart)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 58.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              imagePath,
              height: 99,
              color: theme.iconTheme.color,
            ),
            const SizedBox(height: 42),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headline5
                  ?.copyWith(color: theme.colorScheme.title),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText2
                  ?.copyWith(color: theme.colorScheme.smallBoldSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++)
          i == index
              ? const IndicatorElement(
                  color: Colors.green,
                  width: 28,
                )
              : const IndicatorElement(
                  color: Colors.grey,
                  width: 8,
                )
      ],
    );
  }
}

class IndicatorElement extends StatelessWidget {
  const IndicatorElement({Key? key, required this.width, required this.color})
      : super(key: key);

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      width: width,
      height: 8,
    );
  }
}
