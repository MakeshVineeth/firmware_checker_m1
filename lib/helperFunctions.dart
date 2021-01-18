import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firmware_checker_m1/constantVals.dart';
import 'package:root/root.dart';
import 'package:http/http.dart';
import 'dart:convert';

final verInfo = '/firmware/verinfo/ver_info.txt';

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
      elevation: brightness == Brightness.light ? 3 : 5,
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
      elevation: 5,
      iconTheme: IconThemeData(
        color: brightness == Brightness.light ? Colors.red : Colors.amber,
      ),
      actionsIconTheme: IconThemeData(
        color: brightness == Brightness.light ? Colors.red : Colors.amber,
      ),
      centerTitle: true,
    ),
  );
}

Future<http.Response> getResponse(String url) async {
  try {
    return await http.get(url);
  } catch (e) {
    return null;
  }
}

Future<bool> getRootAccess() async {
  bool rootStatus = await Root.isRooted();
  return rootStatus;
}

Future<String> checkVer(
    {@required bool rootStatus, @required BuildContext context}) async {
  try {
    if (rootStatus) {
      String contents = await Root.exec(cmd: 'cat $verInfo');
      Map data = jsonDecode(contents);
      Map buildInfos = data['Metabuild_Info'];
      String timeStamp = buildInfos['Time_Stamp'];
      timeStamp = timeStamp.split(' ').elementAt(0);
      String firmwareJsonFile = await DefaultAssetBundle.of(context)
          .loadString("assets/firmware.json");
      final jsonResult = json.decode(firmwareJsonFile) as Map;

      if (jsonResult.containsKey(timeStamp))
        return jsonResult[timeStamp];
      else {
        // if timestamp not present in local json file, check in web now.
        Response response = await getResponse(webUrl);
        Map webJson = jsonDecode(response.body);

        if (webJson.keys.contains(timeStamp))
          return webJson[timeStamp];

        // if not available in web too, just return highest available with + in the end.
        else {
          int highest = 0;

          webJson.values.forEach((val) {
            int temp = int.tryParse(val);
            if (temp > highest) highest = temp;
          });

          return '$highest+';
        }
      }
    }

    // Empty string if no root access.
    else
      return '--';
  } catch (e) {
    return '--';
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
    applicationVersion: '2.0',
    applicationLegalese:
        'This app tells you the current firmware of your Asus Zenfone Max Pro M1. If your current firmware is newer than what is available in offline database, then it will do an online check for the same and give you the firmware information. App Made by @DaftPunker007. Thanks to @ShanuDey for his initial firmware data.');
