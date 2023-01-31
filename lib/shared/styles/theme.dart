
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightMode=ThemeData(
primarySwatch:Colors.deepOrange ,
scaffoldBackgroundColor: Colors.white,
appBarTheme: const AppBarTheme(
titleSpacing: 20.0,
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
bottomNavigationBarTheme: const BottomNavigationBarThemeData(
type: BottomNavigationBarType.fixed,
elevation: 20.0,
selectedItemColor: Colors.deepOrange,
unselectedItemColor: Colors.grey,
backgroundColor: Colors.white,
),
textTheme: const TextTheme(
bodyMedium: TextStyle(
fontSize: 18.0,
fontWeight: FontWeight.w600,
color: Colors.black,
),
labelMedium: TextStyle(
color: Colors.black,
fontSize: 13.0,
),
titleMedium: TextStyle(
color: Colors.deepOrange,
fontSize: 20.0,
fontWeight: FontWeight.bold,
),

),
iconTheme: const IconThemeData(
color: Colors.black,
),

);
ThemeData darkMode=ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    color: HexColor('333739'),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: HexColor('333739'),
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      fontSize: 13.0,
    ),
    titleMedium: TextStyle(
      color: Colors.deepOrange,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),

  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);