import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/colors/app_colors.dart';

class AssetsGenericButton extends StatelessWidget {
  final String title;
  final String id;
  final Icon icon;
  final void Function()? onPressed;
  const AssetsGenericButton({
    super.key,
    required this.title,
    required this.id,
    this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      height: 32.0,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 4.0),
          Text(
            title,
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
