import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/colors/app_colors.dart';
import 'package:tractian_challenge/app/ui/assets/widgest/assets_generic_button.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
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
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              AssetsGenericButton(
                title: 'Power Sensor',
                id: 'Power Sensor',
                icon: Icon(
                  Icons.electric_bolt,
                  color: AppColors.white,
                  size: 14.0,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8.0),
              AssetsGenericButton(
                title: 'Critical',
                id: 'Critical',
                icon: Icon(
                  Icons.error_outline,
                  color: AppColors.white,
                  size: 16.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
