import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screens/start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Future<void> isInitialized = Future.delayed(const Duration(seconds: 2));

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToStart();
  }

  _navigateToStart() async {
    await isInitialized;
    // navigate to StartScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const StartScreen()),
    );
    //
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(252, 221, 61, 1),
            Color.fromRGBO(76, 175, 80, 1),
          ],
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          AssetImages.iconLogoPath,
          height: 160,
        ),
      ),
    );
  }
}
