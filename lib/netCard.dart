import 'package:firmware_checker_m1/DetailCard.dart';
import 'package:flutter/material.dart';
import 'package:internet_speed_test/callbacks_enum.dart';
import 'package:internet_speed_test/internet_speed_test.dart';

class NetCard extends StatefulWidget {
  @override
  _NetCardState createState() => _NetCardState();
}

class _NetCardState extends State<NetCard> {
  String name = '--';
  final title = 'Download Speed';
  final internetSpeedTest = InternetSpeedTest();

  @override
  void initState() {
    super.initState();
    getSpeed();
  }

  String unitStr(int index) => (index == 0) ? ' Kb/s' : ' Mb/s';

  Future<void> getSpeed() async {
    internetSpeedTest.startDownloadTesting(
      onDone: (double transferRate, SpeedUnit unit) {
        setState(() => name = transferRate.toString() + unitStr(unit.index));
      },
      onProgress: (double percent, double transferRate, SpeedUnit unit) {
        setState(() => name = transferRate.toString() + unitStr(unit.index));
      },
      onError: (String errorMessage, String speedTestError) {
        setState(() => name = '--');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      title: title,
      subtitle: name,
    );
  }
}
