import 'package:firmware_checker_m1/ErrorWidget.dart';
import 'package:firmware_checker_m1/helperFunctions.dart';
import 'package:firmware_checker_m1/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:http/http.dart';
import 'package:root/root.dart';
import 'dart:convert';
import 'package:firmware_checker_m1/DetailCard.dart';
import 'package:firmware_checker_m1/constantVals.dart';
import 'package:theme_provider/theme_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _rootStatus = false;
  String firmwareVer;
  final verInfo = '/firmware/verinfo/ver_info.txt';
  final snack = SnackBar(
    content: Text('Refreshed.'),
    duration: const Duration(milliseconds: 375),
  );

  Future<bool> getRootAccess() async {
    bool rootStatus = await Root.isRooted();
    _rootStatus = rootStatus;
    return rootStatus;
  }

  Future<String> checkVer() async {
    try {
      if (_rootStatus) {
        String contents = await Root.exec(cmd: 'cat $verInfo');
        Map data = jsonDecode(contents);
        Map buildInfos = data['Metabuild_Info'];
        String timeStamp = buildInfos['Time_Stamp'];
        timeStamp = timeStamp.split(' ').elementAt(0);
        timeStamp = '2020-11-08';
        String firmwareJsonFile = await DefaultAssetBundle.of(context)
            .loadString("assets/firmware.json");
        final jsonResult = json.decode(firmwareJsonFile) as Map;

        if (jsonResult.containsKey(timeStamp))
          return jsonResult[timeStamp];

        // if timestamp not present in local json file, check in web now.
        else {
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
        return '';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor();
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: true,
        actions: [
          CycleThemeIconButton(),
          IconButton(
            onPressed: () => showAbout(context),
            icon: Icon(Icons.info_rounded),
          )
        ],
      ),
      body: FutureBuilder(
        future: getRootAccess(),
        builder: (context, snapshot) => loadWidgets(snapshot),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => doUpdate(),
        child: Icon(Icons.refresh_rounded),
      ),
    );
  }

  void doUpdate() async {
    bool status = await getRootAccess();
    setState(() {
      _rootStatus = status;
    });
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  Future<void> setStatusBarColor() async {
    await FlutterStatusbarcolor.setStatusBarColor(
        Theme.of(context).scaffoldBackgroundColor);
  }

  Widget loadWidgets(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return LayoutBuilder(
        builder: (context, constraints) => AnimationLimiter(
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DetailCard(
                        title: 'Root Access',
                        subtitle: _rootStatus ? 'Granted' : 'Denied',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                        future: checkVer(),
                        builder: (context, snapshotStr) {
                          if (snapshotStr.connectionState ==
                              ConnectionState.done)
                            return DetailCard(
                              title: 'Current Firmware',
                              subtitle: snapshotStr.data,
                            );
                          else
                            return LoadingIndicator();
                        },
                      ),
                    ],
                  ),
                ),
              ],
              childAnimationBuilder: (widget) => SlideAnimation(
                duration: const Duration(milliseconds: 500),
                horizontalOffset: MediaQuery.of(context).size.width / 3,
                child: FadeInAnimation(
                  duration: const Duration(milliseconds: 375),
                  child: widget,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // For error
    else if (snapshot.hasError)
      return ErrorWidgetCustom();

    // For loading
    else
      return Center(child: LoadingIndicator());
  }
}
