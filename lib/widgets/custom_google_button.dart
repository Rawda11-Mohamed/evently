import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class CustomGoogleButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  CustomGoogleButton({super.key, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(13),
        padding: EdgeInsets.all(9),
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/google2.png'),
              SizedBox(width: 5),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
