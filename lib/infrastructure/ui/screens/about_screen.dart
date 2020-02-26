import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import '../../../constants.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: isLandscape
            ? SingleChildScrollView(
                child: Layout(),
              )
            : Layout(),
      ),
    );
  }
}

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'images/wallet.png',
                    height: 70,
                    width: 70,
                  ),
                ),
              ),
              Text(
                FlutterI18n.translate(context, kTitle),
                style: kTitleTextStyle,
              ),
            ],
          ),
          Divider(),
          DeveloperWidget(),
          DesignerWidget(),
          PolicyWidget(),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              FlutterI18n.translate(context, kCopyRights).toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeveloperWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'images/programmer.png',
            height: 50,
            width: 50,
          ),
        ),
        Text(
          FlutterI18n.translate(context, kDeveloperText).toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            wordSpacing: 1,
            letterSpacing: 3,
          ),
        ),
        Text(
          'grayHatEnigma',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Pacifico',
              letterSpacing: 2),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'salama92work@gmail.com',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 12, letterSpacing: 0.5),
          ),
        ),
      ],
    );
  }
}

class DesignerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'images/designer.png',
            height: 50,
            width: 50,
          ),
        ),
        Text(
          FlutterI18n.translate(context, kDesignerText).toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            wordSpacing: 1,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

class PolicyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'images/privacy.png',
            height: 50,
            width: 50,
          ),
        ),
        Text(
          FlutterI18n.translate(context, kPrivacyPolicy).toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            wordSpacing: 1,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
