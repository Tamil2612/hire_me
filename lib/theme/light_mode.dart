import 'package:flutter/material.dart';

import '../utils/color_resources.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'poppins',
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade100,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade700,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    dragHandleColor: ColorResources.primaryColor,
    dragHandleSize: Size(80, 6),
  ),
); // ThemeData
