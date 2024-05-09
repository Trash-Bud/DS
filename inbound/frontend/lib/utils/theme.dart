import 'package:flutter/material.dart';



const smallWidth = 940;

double sideSheetWidth(context, bool smallScreen) {
  return MediaQuery.of(context).size.width * ((smallScreen) ? 1 : 0.3);
}

bool isSmallScreen(context) {
  return MediaQuery.of(context).size.width < 940;
}


final baseTheme = ThemeData(
  highlightColor: Colors.transparent, // prev 255, 0, 122, 255
  splashColor: Colors.transparent,
  splashFactory: InkRipple.splashFactory,
  scaffoldBackgroundColor: const Color.fromARGB(255, 247, 247, 247),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // remove blue highlight when button is pressed
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 82, 81, 81)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    ),
  ),
  dialogBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  dividerColor: const Color.fromARGB(255, 247, 248, 249),
  primaryColorLight: Colors.cyan[50],
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 134, 145, 173),
    foregroundColor: Color.fromARGB(255, 255, 255, 255),
    surfaceTintColor: Color.fromARGB(255, 255, 255, 255),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: const Color.fromARGB(255, 255, 255, 255),
    splashFactory: NoSplash.splashFactory,
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 255, 255, 255),
        width: 2.0,
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color.fromARGB(255, 77, 199, 228),
  ),
  dividerTheme: const DividerThemeData(
    color: Color.fromARGB(255, 247, 248, 249),
    thickness: 1,
    space: 0,
    indent: 0,
    endIndent: 0,
  ),
  textTheme: Typography.blackCupertino.apply(
    bodyColor: const Color.fromARGB(255, 20, 21, 22),
    displayColor: const Color.fromARGB(255, 20, 21, 22),
    fontFamily: 'TitilliumWeb',
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Color.fromARGB(255, 20, 21, 22),
      fontSize: 16,
    ),
  ),
  iconTheme: const IconThemeData(color: Color.fromARGB(255, 20, 21, 22)),
);
