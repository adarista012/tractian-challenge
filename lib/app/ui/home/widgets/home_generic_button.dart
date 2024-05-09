import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/colors/app_colors.dart';

class HomeGenericButton extends StatelessWidget {
  final String title;
  final String id;
  final void Function()? onPressed;
  const HomeGenericButton({
    super.key,
    required this.title,
    required this.id,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        height: 48.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/home_button_icon.png'),
            Text(
              '   $title',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
