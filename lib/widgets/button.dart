import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';

class WidgetsCustom {
  ElevatedButton customButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.secondaryColor,
        foregroundColor: AppColor.primaryColor,
        minimumSize: Size(double.infinity, 50.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Text(text),
    );
  }
}
