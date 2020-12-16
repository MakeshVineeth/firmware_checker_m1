import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FadeIn(
        child: SpinKitDoubleBounce(
          color: Theme.of(context).appBarTheme.actionsIconTheme.color,
          size: 50.0,
        ),
      ),
    );
  }
}
