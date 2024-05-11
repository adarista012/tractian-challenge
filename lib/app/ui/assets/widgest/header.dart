import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/app/core/colors/app_colors.dart';
import 'package:tractian_challenge/app/ui/assets/assets_controller.dart';
import 'package:tractian_challenge/app/ui/assets/widgest/assets_generic_button.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AssetsController(),
      builder: (controller) {
        return Container(
          height: 124.0,
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            children: [
              CupertinoTextField(
                placeholder: "Search active or Local",
                decoration: BoxDecoration(
                  color: AppColors.grey.withAlpha(100),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                onChanged: controller.onchangeText,
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  AssetsGenericButton(
                    title: 'Power Sensor',
                    id: 'Power Sensor',
                    icon: Icon(
                      Icons.electric_bolt,
                      color: controller.isPressedPowerSensor
                          ? AppColors.white
                          : AppColors.grey,
                      size: 14.0,
                    ),
                    isPressed: controller.isPressedPowerSensor,
                    onPressed: () => controller.onPressed(true),
                  ),
                  const SizedBox(width: 8.0),
                  AssetsGenericButton(
                    title: 'Critical',
                    id: 'Critical',
                    isPressed: controller.isPressedCritical,
                    icon: Icon(
                      Icons.error_outline,
                      color: controller.isPressedCritical
                          ? AppColors.white
                          : AppColors.grey,
                      size: 16.0,
                    ),
                    onPressed: () => controller.onPressed(false),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
