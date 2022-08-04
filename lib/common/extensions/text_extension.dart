import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/theme.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get thin => weight(FontWeight.w100);

  TextStyle get extraLight => weight(FontWeight.w200);

  TextStyle get light => weight(FontWeight.w300);

  TextStyle get regular => weight(FontWeight.w400);

  TextStyle get medium => weight(FontWeight.w500);

  TextStyle get semiBold => weight(FontWeight.w600);

  TextStyle get bold => weight(FontWeight.w700);

  TextStyle get w9 => weight(FontWeight.w900);

  TextStyle get w8 => weight(FontWeight.w800);

  TextStyle get italic => fontStyleT(FontStyle.italic);

  TextStyle get normal => fontStyleT(FontStyle.normal);

  TextStyle size(double size) => copyWith(fontSize: size);

  TextStyle textColor(Color v) => copyWith(color: v);

  TextStyle weight(FontWeight v) => GoogleFonts.nunito(textStyle:this,fontWeight: v);

  TextStyle fontStyleT(FontStyle v) => copyWith(fontStyle: v);

  TextStyle setDecoration(TextDecoration v) => copyWith(decoration: v);

  TextStyle letterSpaC(double v) => copyWith(letterSpacing: v);

  TextStyle heightLine(double v) => copyWith(height: v / fontSize!);

  TextStyle get textGreyBBBBBB => textColor(AppColors.colorGreyBBBBBB);

  TextStyle get textGrey797979 => textColor(AppColors.colorGrey797979);

  TextStyle get textGreyF6F6F6 => textColor(AppColors.colorGreyF6F6F6);

  TextStyle get textGreyF6F7FB => textColor(AppColors.colorGreyF6F7FB);

  TextStyle get textRedE53535 => textColor(AppColors.colorRedE53535);

  TextStyle get textWhite => textColor(Colors.white);

  TextStyle get textPrimary => textColor(AppColors.primary);

  TextStyle get textBlack => textColor(AppColors.black);

  TextStyle get decorationUnderline => setDecoration(TextDecoration.underline);
}
