import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.blueGrey[300],
    fontFamily: 'Roboto',
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.black,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(color: Colors.white60),
  );
}
