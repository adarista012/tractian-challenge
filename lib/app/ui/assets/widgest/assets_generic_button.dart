import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/colors/app_colors.dart';

class AssetsGenericButton extends StatelessWidget {
  final String title;
  final String id;
  final Icon icon;
  final bool isPressed;
  final void Function()? onPressed;

  const AssetsGenericButton({
    super.key,
    required this.title,
    required this.id,
    this.onPressed,
    required this.icon,
    required this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: isPressed ? Theme.of(context).primaryColor : AppColors.white,
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
              color: isPressed ? AppColors.white : AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
