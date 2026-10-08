import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class CustomQuestionButton extends StatelessWidget {
  final String text;
  final String already;
  CustomQuestionButton({super.key, required this.text, required this.already});
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '$already have an account ?',
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
