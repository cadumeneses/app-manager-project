import 'package:app_manager_project/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../utils/custom_color.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Column(
        children: [
          Image.asset('assets/images/brisa_logo1.png'),
          const Text(
            'Manager Projects',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: CustomColor.whiteColor
            ),
          )
        ],
      ),
      nextScreen: const AuthPage(),
      splashIconSize: 250,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: CustomColor.primaryColor,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
