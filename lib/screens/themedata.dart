import 'package:flutter/material.dart';

class MyTheme{

      static final darkTheme = ThemeData(
          cardTheme: CardTheme(
            color: Colors.black,
          ),

       brightness: Brightness.dark,
       primarySwatch: Colors.green,
       colorScheme: const ColorScheme.dark(
         primary: Colors.blue,
         secondary: Colors.redAccent,)

       );

    static final lightTheme = ThemeData(
      cardTheme: CardTheme(
        color: Colors.white,
      ),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(),
    );
}