import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle _poppins = GoogleFonts.poppins();

final ThemeData APP_DARK_THEME = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,

  // Core colors
  primaryColor: ColorResource.PRIMARY,
  canvasColor: ColorResource.CANVAS_DARK_PRIMARY,
  scaffoldBackgroundColor: ColorResource.SCAFFOLD_BACKGROUND_DARK,

  // AppBar
  appBarTheme: const AppBarTheme(
    foregroundColor: ColorResource.PRIMARY,
    backgroundColor: ColorResource.CANVAS_DARK_SECONDARY,
    elevation: 2.0,
    centerTitle: true,
  ),

  // Text theme
  textTheme: TextTheme(
    bodyLarge: _poppins.copyWith(
      fontSize: 16.0,
      color: ColorResource.TEXT_TITLE_LIGHT,
    ),
    bodyMedium: _poppins.copyWith(
      fontSize: 14.0,
      color: ColorResource.TEXT_TITLE_LIGHT,
    ),
    bodySmall: _poppins.copyWith(
      fontSize: 12.0,
      color: ColorResource.TEXT_TITLE_LIGHT,
    ),
    titleLarge: _poppins.copyWith(
      fontSize: 22.0,
      color: ColorResource.TEXT_TITLE_LIGHT,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: _poppins.copyWith(
      fontSize: 20.0,
      color: ColorResource.TEXT_TITLE_LIGHT,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: _poppins.copyWith(
      fontSize: 18.0,
      color: ColorResource.TEXT_TITLE_LIGHT,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: _poppins.copyWith(
      fontSize: 32.0,
      color: ColorResource.TEXT_TITLE_LIGHT,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: _poppins.copyWith(
      fontSize: 30.0,
      color: ColorResource.TEXT_TITLE_LIGHT,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: _poppins.copyWith(
      fontSize: 28.0,
      color: ColorResource.TEXT_TITLE_LIGHT,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: _poppins.copyWith(
      fontSize: 16.0,
      color: ColorResource.TEXT_SUBTITLE_LIGHT,
    ),
    labelMedium: _poppins.copyWith(
      fontSize: 14.0,
      color: ColorResource.TEXT_SUBTITLE_LIGHT,
    ),
    labelSmall: _poppins.copyWith(
      fontSize: 12.0,
      color: ColorResource.TEXT_SUBTITLE_LIGHT,
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
    color: ColorResource.CANVAS_DARK_PRIMARY,
    margin: const EdgeInsets.all(8.0),
  ),

  // Icon
  iconTheme: const IconThemeData(size: 22, color: ColorResource.PRIMARY),

  // Bottom sheet
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: ColorResource.CANVAS_DARK_PRIMARY,
    dragHandleColor: ColorResource.CANVAS_DARK_SECONDARY,
    elevation: 8.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
  ),

  // Dialog
  dialogTheme: DialogThemeData(
    backgroundColor: ColorResource.CANVAS_DARK_SECONDARY,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    titleTextStyle: _poppins.copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: ColorResource.TEXT_TITLE_LIGHT,
    ),
    contentTextStyle: _poppins.copyWith(
      fontSize: 14.0,
      color: ColorResource.TEXT_SUBTITLE_LIGHT,
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
    backgroundColor: ColorResource.CANVAS_DARK_SECONDARY,
    selectedItemColor: ColorResource.TEXT_TITLE_LIGHT,
    unselectedItemColor: ColorResource.TEXT_SUBTITLE_LIGHT,
    selectedIconTheme: IconThemeData(color: ColorResource.PRIMARY),
    unselectedIconTheme: IconThemeData(
      color: ColorResource.TEXT_SUBTITLE_LIGHT,
    ),
  ),

  // Divider
  dividerTheme: const DividerThemeData(
    color: ColorResource.TEXT_SUBTITLE_LIGHT,
    thickness: 1.0,
    space: 1.0,
  ),

  // Tooltip
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: ColorResource.CANVAS_DARK_SECONDARY,
      borderRadius: BorderRadius.circular(8.0),
    ),
    textStyle: _poppins.copyWith(color: ColorResource.TEXT_TITLE_LIGHT),
  ),

  // SnackBar
  snackBarTheme: SnackBarThemeData(
    backgroundColor: ColorResource.CANVAS_DARK_SECONDARY,
    contentTextStyle: _poppins.copyWith(color: ColorResource.TEXT_TITLE_LIGHT),
    actionTextColor: ColorResource.PRIMARY,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),

  // Drawer
  drawerTheme: const DrawerThemeData(
    backgroundColor: ColorResource.CANVAS_DARK_PRIMARY,
    scrimColor: ColorResource.TEXT_SUBTITLE_LIGHT,
    elevation: 16.0,
  ),

  // TabBar
  tabBarTheme: TabBarThemeData(
    labelColor: ColorResource.PRIMARY,
    unselectedLabelColor: ColorResource.TEXT_SUBTITLE_LIGHT,
    labelStyle: _poppins.copyWith(fontWeight: FontWeight.bold),
    unselectedLabelStyle: _poppins,
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(color: ColorResource.PRIMARY, width: 2.0),
    ),
  ),

  // Popup menu
  popupMenuTheme: PopupMenuThemeData(
    color: ColorResource.CANVAS_DARK_SECONDARY,
    textStyle: _poppins.copyWith(color: ColorResource.TEXT_TITLE_LIGHT),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),

  // Checkbox
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateColor.resolveWith((state) {
      if (state.contains(WidgetState.disabled)) {
        return Colors.grey.shade700;
      }
      return state.contains(WidgetState.selected)
          ? ColorResource.PRIMARY
          : Colors.transparent;
    }),
    overlayColor: WidgetStatePropertyAll(Colors.red),
    checkColor: WidgetStatePropertyAll(ColorResource.TEXT_TITLE_LIGHT),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    side: const BorderSide(width: 1, color: ColorResource.TEXT_TITLE_LIGHT),
  ),

  // Radio
  radioTheme: RadioThemeData(
    fillColor: WidgetStatePropertyAll(ColorResource.PRIMARY),
  ),

  // Switch
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStatePropertyAll(ColorResource.PRIMARY),
    trackColor: WidgetStatePropertyAll(ColorResource.CANVAS_DARK_SECONDARY),
  ),

  // Slider
  sliderTheme: const SliderThemeData(
    activeTrackColor: ColorResource.PRIMARY,
    inactiveTrackColor: Colors.grey,
    thumbColor: ColorResource.PRIMARY,
    overlayColor: Colors.grey,
  ),

  // Input decoration
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ColorResource.CANVAS_DARK_SECONDARY,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: ColorResource.PRIMARY),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: ColorResource.PRIMARY, width: 2.0),
    ),
    labelStyle: _poppins.copyWith(color: ColorResource.TEXT_SUBTITLE_LIGHT),
    hintStyle: _poppins.copyWith(color: ColorResource.TEXT_SUBTITLE_DARK),
  ),
);
