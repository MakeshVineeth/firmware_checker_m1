import 'package:flutter/material.dart';
import 'package:firmware_checker_m1/constantVals.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String subtitle;

  DetailCard({@required this.title, @required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          shape: borderShape,
          onTap: () {},
          title: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                ),
              ),
            ),
          ),
          subtitle: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color:
                      Theme.of(context).appBarTheme.textTheme.headline6.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
