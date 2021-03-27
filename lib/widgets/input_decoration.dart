import 'package:fitcards/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration build(String defaultText) => InputDecoration(
      errorStyle: TextStyle(
        color: Colors.white.withOpacity(0.7),
        fontStyle: FontStyle.italic,
      ),
      errorBorder: new OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.withOpacity(0.7), width: 2),
        borderRadius: const BorderRadius.all(
          const Radius.circular(8),
        ),
      ),
      border: new OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(
          const Radius.circular(8),
        ),
      ),
      fillColor: AppColors.mandarin,
      filled: true,
      hintText: defaultText,
      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      hintStyle: TextStyle(color: Colors.white70, fontSize: 18, fontStyle: FontStyle.italic));
}