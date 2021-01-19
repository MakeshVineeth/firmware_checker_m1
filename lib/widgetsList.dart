import 'package:firmware_checker_m1/currentFirmwareCard.dart';
import 'package:firmware_checker_m1/security_patch.dart';
import 'package:firmware_checker_m1/system_name.dart';
import 'package:flutter/material.dart';
import 'package:firmware_checker_m1/DetailCard.dart';
import "package:system_info/system_info.dart";
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class WidgetsList extends StatelessWidget {
  final bool rootStatus;
  final int megaByte = 1024 * 1024;

  const WidgetsList({@required this.rootStatus});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => AnimationLimiter(
        child: ListView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          cacheExtent: 1000,
          primary: true,
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
                      subtitle: rootStatus ? 'Granted' : 'Denied',
                    ),
                    SizedBox(height: 5),
                    DetailCard(
                      title: 'RAM',
                      subtitle:
                          '${SysInfo.getTotalPhysicalMemory() ~/ megaByte} MB',
                    ),
                    SizedBox(height: 5),
                    DetailCard(
                      title: 'Kernel',
                      subtitle:
                          '${SysInfo.kernelName} : ${SysInfo.kernelVersion}',
                    ),
                    SizedBox(height: 5),
                    CurrentFirmware(rootStatus: rootStatus),
                    SizedBox(height: 5),
                    SystemName(),
                    SizedBox(height: 5),
                    SecurityPatch()
                  ],
                ),
              ),
            ],
            childAnimationBuilder: (widget) => SlideAnimation(
              duration: const Duration(milliseconds: 500),
              horizontalOffset: 30,
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
}
