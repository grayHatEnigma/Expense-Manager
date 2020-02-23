import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import '../../../constants.dart';
import '../../../domain/models/navigation_model.dart';
import './navigation_list_tile.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    'images/plant.png',
                    height: 70,
                    width: 70,
                  ),
                  Text(
                    FlutterI18n.translate(context, kTitle),
                    style: kTitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = navigationItems[index];
                  return NavigationListTile(
                    title: item.title,
                    iconPath: item.iconPath,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, item.destination);
                    },
                  );
                },
                itemCount: navigationItems.length),
          ),
        ],
      ),
    );
  }
}
