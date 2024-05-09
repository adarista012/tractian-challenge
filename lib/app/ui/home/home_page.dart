import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/app/core/colors/app_colors.dart';
import 'package:tractian_challenge/app/ui/home/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Image.asset('assets/logo.png'),
      ),
      body: GetBuilder(
        init: HomeController(),
        builder: (controller) {
          return Center(
            child: controller.isLoading
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.only(
                      right: 16.0,
                      left: 16.0,
                      top: 40.0,
                    ),
                    child: Column(
                      children: controller.listOfButtons,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
