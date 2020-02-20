import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import '../widgets/circle_button_widget.dart';
import '../../../constants.dart';
import './settings_choice_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            FlutterI18n.translate(context, kSettingsTitle),
            style: TextStyle(letterSpacing: 1),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleButton(
                    color: Colors.teal,
                    icon: Icons.monetization_on,
                    title: FlutterI18n.translate(context, kSalaryButton),
                    onPressed: () {
                      Navigator.pushNamed(context, kSettingsChoiceScreenID,
                          arguments: Settings.edit_salary);
                    },
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleButton(
                    color: Colors.pinkAccent,
                    icon: Icons.date_range,
                    title: FlutterI18n.translate(context, kPlanDateButton),
                    onPressed: () {
                      Navigator.pushNamed(context, kSettingsChoiceScreenID,
                          arguments: Settings.edit_plan_date);
                    },
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleButton(
                    color: Colors.red,
                    icon: Icons.delete_forever,
                    title: FlutterI18n.translate(context, kResetButton),
                    onPressed: () {
                      Navigator.pushNamed(context, kSettingsChoiceScreenID,
                          arguments: Settings.reset);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
