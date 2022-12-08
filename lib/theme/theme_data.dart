import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../common/common.dart';
import 'theme.dart';

class AirTalkThemeData {
  static final InputBorder _inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.colorGreyE2E0E0),
    borderRadius: BorderRadius.circular(10),
  );
  static final themeData = ThemeData(
    fontFamily: GoogleFonts.nunito().fontFamily,
    splashColor: Colors.transparent,
    primaryColor: AppColors.primary,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.primary,size: 40),
      elevation: 0,
      color: Colors.white,
      actionsIconTheme: const IconThemeData(color: AppColors.black),
      titleTextStyle: _textTheme.headline4!.bold,
    ),
    canvasColor: _colorScheme.background,
    toggleableActiveColor: _colorScheme.primary,
    indicatorColor: _colorScheme.onPrimary,
    bottomAppBarColor: Colors.white,
    scaffoldBackgroundColor: _colorScheme.background,
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),

    textTheme: _textTheme,
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: const Color(0xffBFBFBF),
      labelStyle: _textTheme.subtitle1,
      unselectedLabelStyle: _textTheme.subtitle1,
    ),
    // input
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 2,
      helperMaxLines: 2,
      isDense: true,
      labelStyle: _textTheme.headline6!.regular.textBlack,
      hintStyle: _textTheme.subtitle1!.regular.textGreyBBBBBB,
      focusedBorder: _inputBorder,
      border: _inputBorder,
      enabledBorder: _inputBorder,
      errorBorder: _inputBorder.copyWith(
          borderSide: BorderSide(
        color: _colorScheme.error,
      )),
      focusedErrorBorder: _inputBorder.copyWith(
        borderSide: BorderSide(
          color: _colorScheme.error,
        ),
      ),
      disabledBorder: _inputBorder,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 22,
      ),
    ),

    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 15,
      shadowColor: Colors.black.withOpacity(0.1),
      color: Colors.white,
    ),

    dividerTheme: DividerThemeData(space: 24, color: Colors.grey.shade200, thickness: 1),

    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10000),
      ),
      padding: EdgeInsets.zero,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: AppColors.colorSubOrange, elevation: 1,
        minimumSize: const Size(75, 75), disabledForegroundColor: Colors.grey.withOpacity(0.38), disabledBackgroundColor: Colors.grey.withOpacity(0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(75, 75),
        side: const BorderSide(width: 1.5, color: AppColors.colorSubOrange),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000),
        ),
      ),
    ),
    colorScheme: _colorScheme.copyWith(secondary: AppColors.colorSubOrange),
  );

  static const _regular = FontWeight.w400;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static const _colorScheme = ColorScheme(
    primary: AppColors.primary,
    secondary: AppColors.primary,
    background: Colors.white,
    onBackground: AppColors.black,
    surface: Colors.white,
    onSurface: AppColors.primary,
    error: AppColors.colorRedE53535,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    brightness: Brightness.light,
  );

  static const _textTheme = TextTheme(
    headline3:
        TextStyle(fontWeight: _bold, fontSize: 34.0, height: 42 / 34, color: AppColors.black),
    headline4:
        TextStyle(fontWeight: _bold, fontSize: 24.0, height: 28.0 / 24.0, color: AppColors.black),
    headline5:
        TextStyle(fontWeight: _bold, fontSize: 20.0, height: 24.0 / 20.0, color: AppColors.black),
    headline6:
        TextStyle(fontWeight: _bold, fontSize: 18.0, height: 22.0 / 18.0, color: AppColors.black),
    subtitle1: TextStyle(
        fontWeight: _regular, fontSize: 18.0, height: 22.0 / 18.0, color: AppColors.black),
    subtitle2: TextStyle(
        fontWeight: _semiBold, fontSize: 14.0, height: 18.0 / 14.0, color: AppColors.black),
    bodyText1:
        TextStyle(fontWeight: _bold, fontSize: 16.0, height: 20.0 / 16.0, color: AppColors.black),
    bodyText2: TextStyle(
        fontWeight: _regular, fontSize: 14.0, height: 18.0 / 14.0, color: AppColors.black),
    button: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 22.0, height: 22.0 / 22.0, color: AppColors.black),
    caption: TextStyle(
        fontWeight: _regular, fontSize: 12.0, height: 16.0 / 12.0, color: AppColors.black),
    overline: TextStyle(
        fontWeight: _regular,
        fontSize: 10.0,
        height: 14.0 / 10.0,
        color: AppColors.primary,
        letterSpacing: 0),
  );
}
