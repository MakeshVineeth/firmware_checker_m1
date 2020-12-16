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
    return await http.get(url);
  } catch (e) {
    return null;
  }
}

void showAbout(BuildContext context) => showAboutDialog(
    context: context,
    applicationIcon: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image(
        image: AssetImage('assets/logo.png'),
        width: 50,
      ),
    ),
    applicationName: appTitle,
    applicationVersion: '1.0',
    applicationLegalese:
        'This app tells you the current firmware of your Asus Zenfone Max Pro M1. If your current firmware is newer than what is available in offline database, then it will do an online check for the same and give you the firmware information. App Made by @DaftPunker007. Thanks to @ShanuDey for his firmware JSON file.');
