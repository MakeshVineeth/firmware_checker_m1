import 'package:firmware_checker_m1/DetailCard.dart';
import 'package:flutter/material.dart';
import 'package:firmware_checker_m1/helperFunctions.dart';

class CurrentFirmware extends StatefulWidget {
  final bool rootStatus;
  const CurrentFirmware({@required this.rootStatus});

  @override
  _CurrentFirmwareState createState() => _CurrentFirmwareState();
}

class _CurrentFirmwareState extends State<CurrentFirmware> {
  Future<String> ver;

  @override
  void initState() {
    super.initState();
    ver = checkVer(rootStatus: widget.rootStatus, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ver,
      builder: (context, snapshotStr) {
        if (snapshotStr.connectionState == ConnectionState.done)
          return DetailCard(
            title: 'Current Firmware',
            subtitle: snapshotStr.data,
          );
        else
          return DetailCard(
            title: 'Current Firmware',
            subtitle: '--',
          );
      },
    );
  }
}
