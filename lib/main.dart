import 'package:firmware_checker_m1/ScaffoldHome.dart';
import 'package:firmware_checker_m1/helperFunctions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firmware_checker_m1/constantVals.dart';

void main() {
  runApp(RootApp());
  GestureBinding.instance.resamplingEnabled = true;
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      themeMode: ThemeMode.system,
      theme: getTheme(context, Brightness.light),
      darkTheme: getTheme(context, Brightness.dark),
      home: Home(),
    );
  }
}
