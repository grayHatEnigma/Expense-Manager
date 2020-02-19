//flutter core
import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import '../../../constants.dart';

class AdaptiveSwitch extends StatefulWidget {
  final Function switchState;
  AdaptiveSwitch({this.switchState});
  @override
  _AdaptiveSwitchState createState() => _AdaptiveSwitchState();
}

class _AdaptiveSwitchState extends State<AdaptiveSwitch> {
  bool _showChart = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          FlutterI18n.translate(context, kShowChartButton),
          style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColor),
        ),
        Switch.adaptive(
          value: _showChart,
          onChanged: (value) {
            setState(() {
              _showChart = value;
              widget.switchState(value);
            });
          },
        ),
      ],
    );
  }
}
