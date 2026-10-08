import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final Icon prefixIcon;
  final bool? isVisable;
  VoidCallback? onPressed;
  final bool isPassword;
  final TextEditingController? controller;

  final String hintText;
  CustomTextField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    required this.isPassword,
    this.controller,
    this.isVisable,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        obscureText: isVisable == true ? true : false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          fillColor: Theme.of(context).colorScheme.surface,
          prefixIcon: prefixIcon,

          prefixIconColor: Theme.of(context).colorScheme.onSurface,
          suffixIcon:
              isPassword == true
                  ? isVisable == true
                      ? IconButton(
                        icon: Icon(Icons.visibility_off_outlined),
                        onPressed: onPressed,
                      )
                      : IconButton(
                        icon: Icon(Icons.visibility_outlined),
                        onPressed: onPressed,
                      )
                  : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
      ),
    );
  }
}
