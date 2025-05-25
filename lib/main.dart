import 'package:flutter/material.dart';
import 'package:yomiru/frontend/homePage.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    ),
    home: HomePage(),
  ));
}