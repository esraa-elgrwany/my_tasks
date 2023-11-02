import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MyThemeData{

  static ThemeData lightTheme=ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary:primaryColor, onPrimary:primaryColor, secondary: Colors.black,
        onSecondary:Colors.black, error: Colors.red, onError: Colors.red,
        background:mint,
        onBackground:Colors.white,
        surface:Colors.white,
        onSurface: Colors.black),

      scaffoldBackgroundColor: mint,
      appBarTheme: AppBarTheme(
        color: primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white
        )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
      ),
    textTheme: TextTheme(
      bodySmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color:Colors.black,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color:primaryColor,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color:Colors.white,
      ),
    ),
  );
  static ThemeData darkTheme=ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary:primaryColor, onPrimary: Colors.white, secondary:grey,
        onSecondary:Colors.black, error: Colors.red, onError: Colors.red,
        background:darkBg,
        onBackground:Colors.white,
        surface:darkgrey,
        onSurface: Colors.white),

      scaffoldBackgroundColor: darkBg,
    appBarTheme: AppBarTheme(
      color: primaryColor,
        iconTheme: IconThemeData(
            color: Colors.black
        )
    ),
      textTheme: TextTheme(
        bodySmall: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color:Colors.white,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color:primaryColor,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color:Colors.black,
        ),
      ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.white,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
  );
}