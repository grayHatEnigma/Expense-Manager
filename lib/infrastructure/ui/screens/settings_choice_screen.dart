import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../../constants.dart';
import '../../../domain/managers/ui_manager.dart';

class SettingsChoiceScreen extends StatefulWidget {
  @override
  _SettingsChoiceScreenState createState() => _SettingsChoiceScreenState();
}

class _SettingsChoiceScreenState extends State<SettingsChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    final uiManager = Provider.of<UiManager>(context);
    final choice = ModalRoute.of(context).settings.arguments as Settings;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          FlutterI18n.translate(context, kSettingsTitle),
          style: TextStyle(letterSpacing: 2),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (choice == Settings.reset) resetAllTransactions(),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.red,
                  child: Text(
                    FlutterI18n.translate(context, kCancelButton),
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                    color: Colors.green,
                    child: Text(
                      FlutterI18n.translate(context, kConfirmButton),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      switch (choice) {
                        case Settings.reset:
                          onReset(uiManager);
                          break;
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget resetAllTransactions() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        FlutterI18n.translate(context, kResetMsg),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.red[700], fontSize: 20, fontStyle: FontStyle.italic),
      ),
    );
  }

  void onReset(UiManager uiManager) {
    uiManager.reset();
    Navigator.pop(context);
  }
}

enum Settings { reset }
