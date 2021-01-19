import 'package:firmware_checker_m1/DetailCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:system_properties/system_properties.dart';

class SystemName extends StatefulWidget {
  @override
  _SystemNameState createState() => _SystemNameState();
}

class _SystemNameState extends State<SystemName> {
  Future<String> name;
  final title = 'Android Security Patch';

  @override
  void initState() {
    super.initState();
    name = getSDKVersion();
  }

  Future<String> getSDKVersion() async {
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
      DateTime dateTime = DateTime.tryParse(str);
      str = DateFormat.yMMMMd('en_US').format(dateTime);
    }

    return str ?? '--';
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
