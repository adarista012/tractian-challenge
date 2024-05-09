import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/app/core/colors/app_colors.dart';
import 'package:tractian_challenge/app/ui/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: GetBuilder(
        init: splashController,
        builder: (_) {
          return Center(
            child: Image.asset(
              'assets/logo.png',
            ),
          );
        },
      ),
    );
  }
}
