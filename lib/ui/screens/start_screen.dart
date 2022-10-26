import 'package:flutter/material.dart';
import 'package:places/main_page.dart';
import 'package:places/ui/screens/onboarding_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardindShowProvider(
      model: OnboardingShowModel(),
      child: OnBoardindShowProvider.watch(context)?.shown ?? false
          ? const MainPage()
          : const OnboardingScreen(),
    ); 
  }
}

class OnboardingShowModel extends ChangeNotifier {
  bool _shown = false;

  bool get shown => _shown;

  void endShow() {
    _shown = true;
    notifyListeners();
  }
}

class OnBoardindShowProvider extends InheritedNotifier<OnboardingShowModel> {
  final OnboardingShowModel model;

  const OnBoardindShowProvider(
      {required this.model, required Widget child, Key? key})
      : super(key: key, notifier: model, child: child);

  //подписка
  static OnboardingShowModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OnBoardindShowProvider>()
        ?.model;
  }

  //чтение
  static OnboardingShowModel? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<OnBoardindShowProvider>()
        ?.widget;
    return widget is OnBoardindShowProvider ? widget.notifier : null;
  }
}
