import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firmware_checker_m1/constantVals.dart';

ThemeData getTheme(BuildContext context, Brightness brightness) {
  Color bg = Colors.white;
  Color fg = Colors.black;

  if (brightness == Brightness.dark) {
    bg = Colors.black;
    fg = Colors.white;
  }

  return ThemeData(
    brightness: brightness,
    scaffoldBackgroundColor: bg,
    cardColor: bg,
    applyElevationOverlayColor: brightness == Brightness.dark,
    cardTheme: CardTheme(
      shape: borderShape,
      color: bg,
      elevation: brightness == Brightness.light ? 2 : 5,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: fg,
      backgroundColor: bg,
    ),
    appBarTheme: AppBarTheme(
        color: bg,
        textTheme: TextTheme(
          headline6: Theme.of(context).textTheme.headline6.copyWith(
                color: fg,
              ),
        ),
        actionsIconTheme: IconThemeData(
          color: brightness == Brightness.light ? Colors.red : Colors.amber,
        )),
  );
}

Future<http.Response> getResponse(String url) async {
  try {
    String httpTag = 'https://';
    return await http.get('$httpTag$url');
  } catch (e) {
    return null;
  }
}
