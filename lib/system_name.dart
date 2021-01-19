import 'package:firmware_checker_m1/DetailCard.dart';
import 'package:flutter/material.dart';
import 'package:system_properties/system_properties.dart';

class SystemName extends StatefulWidget {
  @override
  _SystemNameState createState() => _SystemNameState();
}

class _SystemNameState extends State<SystemName> {
  Future<String> name;
  final title = 'System Name';

  @override
  void initState() {
    super.initState();
    name = getSDKVersion();
  }

  Future<String> getSDKVersion() async =>
      await SystemProperties.getSystemProperties('ro.product.system.name');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: name,
      builder: (context, snapshotStr) {
        if (snapshotStr.connectionState == ConnectionState.done)
          return DetailCard(
            title: title,
            subtitle: snapshotStr.data,
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
