import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

extension ElevatedButtonFromTextExtension on Widget {
  ElevatedButton elevatedButton(
      {required VoidCallback? onPressed, Color? bgColor, Color? colorTitle}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: this,
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.black54,
        elevation: 5,
        primary: bgColor ?? AppColors.colorSubOrange,
        onPrimary: colorTitle ?? Colors.white,
      ),
    );
  }

  OutlinedButton outlinedButton({required VoidCallback? onPressed, Color? color}) {
    return OutlinedButton(
      onPressed: onPressed,
      child: this,
      style: ElevatedButton.styleFrom(
        onPrimary: color ?? AppColors.colorSubOrange,
        side: BorderSide(width: 1.5, color: color ?? AppColors.colorSubOrange),
      ),
    );
  }
}
