import 'package:firmware_checker_m1/helperFunctions.dart';
import 'package:firmware_checker_m1/widgetsList.dart';
import 'package:flutter/material.dart';
import 'package:firmware_checker_m1/loadingIndicator.dart';

class ScaffoldBody extends StatelessWidget {
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: UniqueKey(),
      future: getRootAccess(),
      builder: (context, snapshot) => loadWidgets(snapshot),
    );
  }

  Widget loadWidgets(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done)
      return WidgetsList(rootStatus: snapshot.data);

    // For loading
    else
      return Center(child: LoadingIndicator());
  }
}
