import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../domain/managers/plan_manager.dart';
import '../widgets/circle_button_widget.dart';
import '../../../constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final planManager = Provider.of<PlanManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            kTitle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
                child: Text(
              'Settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.purple,
                letterSpacing: 2,
              ),
            )),
            Flexible(
              child: CircleButton(
                color: Colors.teal,
                icon: Icons.monetization_on,
                title: 'Salary',
              ),
            ),
            Flexible(
              child: CircleButton(
                color: Colors.pinkAccent,
                icon: Icons.date_range,
                title: 'Plan Date',
              ),
            ),
            Flexible(
              child: CircleButton(
                color: Colors.red,
                icon: Icons.delete_forever,
                title: 'Reset',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
