import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputDecoration {
  static InputDecoration build(String defaultText) => InputDecoration(
      errorStyle: TextStyle(
        color: Colors.red,
        fontStyle: FontStyle.italic,
      ),
      errorBorder: new OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: const BorderRadius.all(
          const Radius.circular(8),
        ),
      ),
      border: new OutlineInputBorder(
        borderSide: BorderSide(
            color: Theme.of(Get.context!).primaryColor.withOpacity(0.7),
            width: 2),
        borderRadius: const BorderRadius.all(
          const Radius.circular(8),
        ),
      ),
      enabledBorder: new OutlineInputBorder(
        borderSide: BorderSide(
            color: Theme.of(Get.context!).primaryColor.withOpacity(0.7),
            width: 2),
        borderRadius: const BorderRadius.all(
          const Radius.circular(8),
        ),
      ),
      focusedBorder: new OutlineInputBorder(
        borderSide: BorderSide(
            color: Theme.of(Get.context!).primaryColor.withOpacity(0.7),
            width: 2),
        borderRadius: const BorderRadius.all(
          const Radius.circular(8),
        ),
      ),
      fillColor: Theme.of(Get.context!).canvasColor.withOpacity(0.5),
      filled: true,
      hintText: defaultText,
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      hintStyle: TextStyle(
          color: Theme.of(Get.context!).primaryColor.withOpacity(0.7),
          fontSize: 18,
          fontStyle: FontStyle.italic));
}
