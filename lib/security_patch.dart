import 'package:firmware_checker_m1/DetailCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:system_properties/system_properties.dart';

class SecurityPatch extends StatefulWidget {
  @override
  _SecurityPatchState createState() => _SecurityPatchState();
}

class _SecurityPatchState extends State<SecurityPatch> {
  Future<String> name;
  final title = 'Android Security Patch';

  @override
  void initState() {
    super.initState();
    name = getSDKVersion();
  }

  Future<String> getSDKVersion() async {
    try {
      String str = await SystemProperties.getSystemProperties(
          'ro.build.version.real_security_patch');

      if (str == null) {
        str = await SystemProperties.getSystemProperties(
            'ro.build.version.security_patch_real');

        if (str == null) {
          str = await SystemProperties.getSystemProperties(
              'ro.build.version.security_patch');
        }
      }

      if (str != null) {
        DateTime dateTime = DateFormat('yyyy-mm-dd').parse(str);
        str = DateFormat.yMMMMd('en_US').format(dateTime);
      }

      return str ?? '--';
    } catch (e) {
      return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: name,
      builder: (context, snapshotStr) {
        if (snapshotStr.connectionState == ConnectionState.done)
          return DetailCard(
            title: title,
            subtitle: snapshotStr.data.toString(),
          );
        else
          return DetailCard(
            title: title,
            subtitle: '--',
          );
      },
    );
  }
}
