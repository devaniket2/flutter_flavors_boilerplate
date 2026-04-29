import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle _poppins = GoogleFonts.poppins();

final ThemeData APP_LIGHT_THEME = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,

  // Core colors
  primaryColor: ColorResource.PRIMARY,
  canvasColor: ColorResource.CANVAS_LIGHT_PRIMARY,
  scaffoldBackgroundColor: ColorResource.SCAFFOLD_BACKGROUND_LIGHT,

  // AppBar
  appBarTheme: const AppBarTheme(
    foregroundColor: ColorResource.PRIMARY,
    backgroundColor: ColorResource.CANVAS_LIGHT_SECONDARY,
    elevation: 2.0,
    centerTitle: true,
  ),

  // Text theme
  textTheme: TextTheme(
    bodyLarge: _poppins.copyWith(
      fontSize: 16.0,
      color: ColorResource.TEXT_TITLE_DARK,
    ),
    bodyMedium: _poppins.copyWith(
      fontSize: 14.0,
      color: ColorResource.TEXT_TITLE_DARK,
    ),
    bodySmall: _poppins.copyWith(
      fontSize: 12.0,
      color: ColorResource.TEXT_TITLE_DARK,
    ),
    titleLarge: _poppins.copyWith(
      fontSize: 22.0,
      color: ColorResource.TEXT_TITLE_DARK,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: _poppins.copyWith(
      fontSize: 20.0,
      color: ColorResource.TEXT_TITLE_DARK,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: _poppins.copyWith(
      fontSize: 18.0,
      color: ColorResource.TEXT_TITLE_DARK,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: _poppins.copyWith(
      fontSize: 32.0,
      color: ColorResource.PRIMARY,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: _poppins.copyWith(
      fontSize: 28.0,
      color: ColorResource.PRIMARY,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: _poppins.copyWith(
      fontSize: 24.0,
      color: ColorResource.PRIMARY,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: _poppins.copyWith(
      fontSize: 14.0,
      color: ColorResource.TEXT_SUBTITLE_DARK,
    ),
    labelMedium: _poppins.copyWith(
      fontSize: 12.0,
      color: ColorResource.TEXT_SUBTITLE_DARK,
    ),
    labelSmall: _poppins.copyWith(
      fontSize: 10.0,
      color: ColorResource.TEXT_SUBTITLE_DARK,
    ),
  ),

  // Progress indicator
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: ColorResource.PRIMARY,
    strokeWidth: 2,
  ),

  // Card
  cardTheme: CardThemeData(
    elevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    color: ColorResource.CANVAS_LIGHT_PRIMARY,
    margin: const EdgeInsets.all(8.0),
  ),

  // Icon
  iconTheme: const IconThemeData(size: 22, color: ColorResource.PRIMARY),

  // Bottom sheet
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: ColorResource.CANVAS_LIGHT_PRIMARY,
    dragHandleColor: ColorResource.CANVAS_LIGHT_SECONDARY,
    elevation: 8.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
  ),

  // Dialog
  dialogTheme: DialogThemeData(
    backgroundColor: ColorResource.CANVAS_LIGHT_SECONDARY,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    titleTextStyle: _poppins.copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: ColorResource.TEXT_TITLE_DARK,
    ),
    contentTextStyle: _poppins.copyWith(
      fontSize: 14.0,
      color: ColorResource.TEXT_SUBTITLE_DARK,
    ),
  ),

  // Elevated button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorResource.PRIMARY,
      foregroundColor: ColorResource.TEXT_TITLE_LIGHT,
      textStyle: _poppins.copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  ),

  // Text button
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: ColorResource.PRIMARY,
      textStyle: _poppins.copyWith(fontSize: 14.0),
    ),
  ),

  // Outlined button
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ColorResource.PRIMARY,
      side: const BorderSide(color: ColorResource.PRIMARY),
      textStyle: _poppins.copyWith(fontSize: 14.0),
    ),
  ),

  // Floating action button
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorResource.PRIMARY,
    foregroundColor: ColorResource.TEXT_TITLE_LIGHT,
    elevation: 6.0,
  ),

  // Bottom navigation bar
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: ColorResource.CANVAS_LIGHT_SECONDARY,
    selectedItemColor: ColorResource.TEXT_TITLE_DARK,
    unselectedItemColor: ColorResource.TEXT_SUBTITLE_DARK,
    selectedIconTheme: IconThemeData(color: ColorResource.PRIMARY),
    unselectedIconTheme: IconThemeData(color: ColorResource.TEXT_SUBTITLE_DARK),
  ),

  // Divider
  dividerTheme: const DividerThemeData(
    color: ColorResource.TEXT_SUBTITLE_DARK,
    thickness: 1.0,
    space: 1.0,
  ),

  // Tooltip
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: ColorResource.CANVAS_LIGHT_SECONDARY,
      borderRadius: BorderRadius.circular(8.0),
    ),
    textStyle: _poppins.copyWith(color: ColorResource.TEXT_TITLE_DARK),
  ),

  // SnackBar
  snackBarTheme: SnackBarThemeData(
    backgroundColor: ColorResource.CANVAS_LIGHT_SECONDARY,
    contentTextStyle: _poppins.copyWith(color: ColorResource.TEXT_TITLE_DARK),
    actionTextColor: ColorResource.PRIMARY,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),

  // Drawer
  drawerTheme: const DrawerThemeData(
    backgroundColor: ColorResource.CANVAS_LIGHT_PRIMARY,
    scrimColor: Colors.black54,
    elevation: 16.0,
  ),

  // TabBar
  tabBarTheme: TabBarThemeData(
    labelColor: ColorResource.PRIMARY,
    unselectedLabelColor: ColorResource.TEXT_SUBTITLE_DARK,
    labelStyle: _poppins.copyWith(fontWeight: FontWeight.bold),
    unselectedLabelStyle: _poppins,
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(color: ColorResource.PRIMARY, width: 2.0),
    ),
  ),

  // Popup menu
  popupMenuTheme: PopupMenuThemeData(
    color: ColorResource.CANVAS_LIGHT_SECONDARY,
    textStyle: _poppins.copyWith(color: ColorResource.TEXT_TITLE_DARK),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),

  // Checkbox
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey.shade300;
      }
      return states.contains(WidgetState.selected)
          ? ColorResource.PRIMARY
          : Colors.transparent;
    }),
    overlayColor: WidgetStatePropertyAll(
      ColorResource.PRIMARY.withValues(alpha: 0.2),
    ),
    checkColor: WidgetStatePropertyAll(ColorResource.TEXT_TITLE_LIGHT),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    side: const BorderSide(width: 1, color: ColorResource.TEXT_TITLE_DARK),
  ),

  // Radio
  radioTheme: RadioThemeData(
    fillColor: WidgetStatePropertyAll(ColorResource.PRIMARY),
  ),

  // Switch
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStatePropertyAll(ColorResource.PRIMARY),
    trackColor: WidgetStatePropertyAll(ColorResource.CANVAS_LIGHT_SECONDARY),
  ),

  // Slider
  sliderTheme: const SliderThemeData(
    activeTrackColor: ColorResource.PRIMARY,
    inactiveTrackColor: Colors.grey,
    thumbColor: ColorResource.PRIMARY,
    overlayColor: ColorResource.PRIMARY,
  ),

  // Input decoration
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ColorResource.CANVAS_LIGHT_SECONDARY,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: ColorResource.PRIMARY),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: ColorResource.PRIMARY, width: 2.0),
    ),
    labelStyle: _poppins.copyWith(color: ColorResource.TEXT_SUBTITLE_DARK),
    hintStyle: _poppins.copyWith(color: ColorResource.TEXT_SUBTITLE_LIGHT),
  ),
);
