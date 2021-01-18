import 'package:firmware_checker_m1/helperFunctions.dart';
import 'package:firmware_checker_m1/widgetsList.dart';
import 'package:flutter/material.dart';
import 'package:firmware_checker_m1/loadingIndicator.dart';

class ScaffoldBody extends StatefulWidget {
  @override
  _ScaffoldBodyState createState() => _ScaffoldBodyState();
}

class _ScaffoldBodyState extends State<ScaffoldBody> {
  Future<bool> _futureRef;

  @override
  void initState() {
    super.initState();
    _futureRef = getRootAccess();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureRef,
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
