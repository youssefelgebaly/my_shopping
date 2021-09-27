import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'colors.dart';


ThemeData darkTheme= ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 15.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor:Colors.deepOrange
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white
    ),
  ),
  fontFamily: 'Jannah',
);
ThemeData lightTheme= ThemeData(
  //primarySwatch:defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 15.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.black45,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Jannah',
);