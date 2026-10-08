import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarItem extends StatelessWidget {
  final bool isSelected;
  final Icon icon;

  const BottomNavBarItem({required this.isSelected, required this.icon});

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          width: 59,
          height: 34,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(66),
            color: const Color(0x20202099),
          ),
          child: icon,
        )
        : icon;
  }
}
