import 'package:flutter/material.dart';

class ErrorWidgetCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Text(
          'Oops, An Error has Occurred.',
        ),
      ),
    );
  }
}
