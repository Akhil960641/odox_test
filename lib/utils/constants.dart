//main.dart

import 'package:flutter/material.dart';
import 'package:odox_test/utils/colors.dart';

ThemeData themeData = ThemeData(
  appBarTheme:
      const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
  scaffoldBackgroundColor: background,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  useMaterial3: true,
);
