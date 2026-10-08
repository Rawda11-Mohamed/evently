import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      width: double.infinity,
      height: 60,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
