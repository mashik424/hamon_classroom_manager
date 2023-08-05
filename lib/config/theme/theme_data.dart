import 'package:flutter/material.dart';

import 'text_theme.dart';

ThemeData theme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Colors.lightGreen,
  ),
  useMaterial3: true,
  textTheme: textTheme,
).copyWith(
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    centerTitle: true,
  ),
);

ThemeData darkTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.lightGreen,
  ),
  useMaterial3: true,
  textTheme: textTheme,
).copyWith(
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    centerTitle: true,
  ),
);
