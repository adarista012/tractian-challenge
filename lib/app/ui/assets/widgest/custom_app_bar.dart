import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/colors/app_colors.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    foregroundColor: AppColors.white,
    backgroundColor: AppColors.mainColor,
    title: Text(
      'Assets',
      style: TextStyle(
        color: AppColors.white,
      ),
    ),
  );
}
