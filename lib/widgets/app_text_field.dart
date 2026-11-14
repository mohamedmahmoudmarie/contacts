import 'package:flutter/material.dart';

import '../core/app_colors.dart';

/// Text form field styled from the theme's InputDecorationTheme
/// (fill dark blue, gold border 2, red error border, radius 16).
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      cursorColor: AppColors.gold,
      style: const TextStyle(
        color: AppColors.gold,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      decoration: InputDecoration(hintText: hint),
    );
  }
}
