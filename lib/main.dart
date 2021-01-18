import 'package:firmware_checker_m1/ScaffoldHome.dart';
import 'package:firmware_checker_m1/helperFunctions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firmware_checker_m1/constantVals.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  runApp(RootApp());
  GestureBinding.instance.resamplingEnabled = true;
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme(
          id: 'light',
          data: getTheme(context, Brightness.light),
          description: 'light theme',
        ),
        AppTheme(
          id: 'dark',
          data: getTheme(context, Brightness.dark),
          description: 'dark theme',
        ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: appTitle,
            theme: ThemeProvider.themeOf(themeContext).data,
            home: Home(),
          ),
        ),
      ),
    );
  }
}
