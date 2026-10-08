import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_theme.dart';

class CatigoriesContainer extends StatelessWidget {
  final String text;
  final String icon;
  VoidCallback onPressed;
  final bool isSelected;
  CatigoriesContainer({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
    required this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      margin: EdgeInsets.all(8),
      width: 140,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 4),
            Text(
              text,
              style: TextStyle(
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
