import 'package:cm_movie/screens/bottom_nav_screen.dart';
import 'package:cm_movie/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(milliseconds: 2500),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottonNavScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/cm.png',
              scale: 7,
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 300))
                .scale(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.fastOutSlowIn)
                .slideY(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut),
            const SizedBox(
              height: 10,
            ),
            const Text('Channel Myanmar')
                .animate()
                .slideX(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(seconds: 1))
                .shimmer(
                    colors: [kBlack, kYellow],
                    duration: const Duration(seconds: 2)),
          ],
        ),
      ),
    );
  }
}
