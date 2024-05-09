import 'package:flutter/material.dart';

final baseTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 247, 248, 249),
  dialogBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  dividerColor: const Color.fromARGB(255, 247, 248, 249),
  highlightColor: const Color.fromARGB(255, 0, 122, 255),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color.fromARGB(255, 77, 199, 228),
  ),
  textTheme: const TextTheme().apply(
    bodyColor: const Color.fromARGB(255, 20, 21, 22),
    displayColor: const Color.fromARGB(255, 20, 21, 22),
  ),
  iconTheme: const IconThemeData(color: Color.fromARGB(255, 20, 21, 22)),
);

const double drawerMinWidth = 70;
const double drawerMaxWidth = 240;
