import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle _poppins = GoogleFonts.poppins();

final ThemeData APP_LIGHT_THEME = ThemeData(
  appBarTheme: const AppBarTheme(foregroundColor: ColorResource.PRIMARY_COLOR),
  useMaterial3: true,
  primaryColor: ColorResource.PRIMARY_COLOR,
  canvasColor: const Color(0xffffffee),
  // scaffold background color
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  // text theme
  textTheme: TextTheme(
    bodyLarge: _poppins.copyWith(
      fontSize: 16.0,
      color: ColorResource.SEMI_BLACK,
    ),
    // flutter uses bodyMedium for default text style, so we set it to 14.0 and semi black color for light theme
    bodyMedium: _poppins.copyWith(
      fontSize: 14.0,
      color: ColorResource.SEMI_BLACK,
    ),
    bodySmall: _poppins.copyWith(
      fontSize: 12.0,
      color: ColorResource.SEMI_BLACK,
    ),
    titleLarge: _poppins.copyWith(
      fontSize: 22.0,
      color: ColorResource.LIGHT_BLACK,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: _poppins.copyWith(
      fontSize: 20.0,
      color: ColorResource.LIGHT_BLACK,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: _poppins.copyWith(
      fontSize: 18.0,
      color: ColorResource.LIGHT_BLACK,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: _poppins.copyWith(
      fontSize: 32.0,
      color: ColorResource.PRIMARY_COLOR,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: _poppins.copyWith(
      fontSize: 28.0,
      color: ColorResource.PRIMARY_COLOR,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: _poppins.copyWith(
      fontSize: 24.0,
      color: ColorResource.PRIMARY_COLOR,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: _poppins.copyWith(fontSize: 14.0, color: Colors.grey),
    labelMedium: _poppins.copyWith(fontSize: 12.0, color: Colors.grey),
    labelSmall: _poppins.copyWith(fontSize: 10.0, color: Colors.grey),
  ),

  // // color scheme
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: ColorResource.PRIMARY_COLOR,
    onPrimary: ColorResource.SEMI_WHITE,
    secondary: ColorResource.PRIMARY_COLOR,
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Color(0xffffffee),
    onSurface: Colors.black,
  ),

  // // card theme
  cardTheme: CardThemeData(
    elevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    color: Colors.white,
  ),

  // icon theme
  iconTheme: const IconThemeData(size: 24, color: ColorResource.PRIMARY_COLOR),

  // // bottom sheet
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.white, // Bottom sheet background color
    dragHandleColor: Colors.grey.shade600,
    elevation: 8.0, // Elevation of the bottom sheet
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
  ),

  buttonTheme: ButtonThemeData(),

  dialogTheme: DialogThemeData(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  ),
);
