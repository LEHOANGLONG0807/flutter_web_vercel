import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

extension ElevatedButtonFromTextExtension on Widget {
  ElevatedButton elevatedButton(
      {required VoidCallback? onPressed, Color? bgColor, Color? colorTitle}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: this,
      style: ElevatedButton.styleFrom(
        foregroundColor: colorTitle ?? Colors.white, shadowColor: Colors.black54, backgroundColor: bgColor ?? AppColors.colorSubOrange,
        elevation: 5,
      ),
    );
  }

  OutlinedButton outlinedButton({required VoidCallback? onPressed, Color? color}) {
    return OutlinedButton(
      onPressed: onPressed,
      child: this,
      style: ElevatedButton.styleFrom(
        foregroundColor: color ?? AppColors.colorSubOrange, side: BorderSide(width: 1.5, color: color ?? AppColors.colorSubOrange),
      ),
    );
  }
}
