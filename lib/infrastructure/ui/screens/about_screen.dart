import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import '../../../constants.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'images/search.png',
                height: 50,
                width: 50,
              ),
            ),
            Text(
              FlutterI18n.translate(context, kDeveloperText).toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                wordSpacing: 1,
                letterSpacing: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 25),
              child: Text(
                'grayHatEnigma',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Pacifico',
                    letterSpacing: 1),
              ),
            ),
            Text(
              FlutterI18n.translate(context, kDesignerText).toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                wordSpacing: 5,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
