import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle _poppins = GoogleFonts.poppins();

final ThemeData APP_DARK_THEME = ThemeData(
  appBarTheme: const AppBarTheme(foregroundColor: ColorResource.PRIMARY_COLOR),
  useMaterial3: true,
  primaryColor: ColorResource.PRIMARY_COLOR,
  canvasColor: ColorResource.SEMI_BLACK,
  // scaffold background color
  scaffoldBackgroundColor: ColorResource.SEMI_BLACK_BG,
  // text theme
  textTheme: TextTheme(
    bodyLarge: _poppins.copyWith(
      fontSize: 16.0,
      color: ColorResource.SEMI_WHITE,
    ),
    bodyMedium: _poppins.copyWith(
      fontSize: 14.0,
      color: ColorResource.SEMI_WHITE,
    ),
    bodySmall: _poppins.copyWith(
      fontSize: 12.0,
      color: ColorResource.SEMI_WHITE,
    ),
    titleLarge: _poppins.copyWith(
      fontSize: 22.0,
      color: ColorResource.WHITE,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: _poppins.copyWith(
      fontSize: 20.0,
      color: ColorResource.WHITE,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: _poppins.copyWith(
      fontSize: 18.0,
      color: ColorResource.WHITE,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: _poppins.copyWith(
      fontSize: 32.0,
      color: ColorResource.WHITE,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: _poppins.copyWith(
      fontSize: 30.0,
      color: ColorResource.WHITE,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: _poppins.copyWith(
      fontSize: 28.0,
      color: ColorResource.WHITE,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: _poppins.copyWith(fontSize: 16.0, color: Colors.grey),
    labelMedium: _poppins.copyWith(fontSize: 14.0, color: Colors.grey),
    labelSmall: _poppins.copyWith(fontSize: 12.0, color: Colors.grey),
  ),

  // // color scheme
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: ColorResource.PRIMARY_COLOR,
    onPrimary: ColorResource.SEMI_WHITE,
    secondary: ColorResource.SEMI_BLACK,
    onSecondary: ColorResource.WHITE,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: ColorResource.SEMI_BLACK_BG,
    onSurface: ColorResource.SEMI_WHITE,
  ),

  //  card theme
  cardTheme: CardThemeData(
    elevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    color: ColorResource.SEMI_BLACK,
  ),

  // icon theme
  iconTheme: const IconThemeData(size: 24, color: ColorResource.PRIMARY_COLOR),

  // bottom sheet
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: ColorResource.SEMI_BLACK, // Bottom sheet background color
    dragHandleColor: Colors.grey.shade600,
    elevation: 8.0, // Elevation of the bottom sheet
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
  ),
);
