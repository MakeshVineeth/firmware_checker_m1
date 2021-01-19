import 'package:firmware_checker_m1/helperFunctions.dart';
import 'package:firmware_checker_m1/scaffoldBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:firmware_checker_m1/constantVals.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final snack = SnackBar(
    content: Text('Refreshed.'),
    duration: const Duration(milliseconds: 375),
  );

  Widget _currentWidget = ScaffoldBody();

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        actions: [
          CycleThemeIconButton(icon: FluentIcons.dark_theme_24_regular),
          IconButton(
            onPressed: () => showAbout(context),
            icon: Icon(FluentIcons.info_28_regular),
          )
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        child: _currentWidget,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => doUpdate(context),
        child: Icon(Icons.refresh_rounded),
      ),
    );
  }

  doUpdate(BuildContext context) async {
    await getRootAccess();
    setState(() {
      _currentWidget = new ScaffoldBody();
    });

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  setStatusBarColor(BuildContext context) async =>
      await FlutterStatusbarcolor.setStatusBarColor(
          Theme.of(context).scaffoldBackgroundColor);
}
