import 'package:flutter/material.dart';

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
                children: <Widget>[
                  Image.asset(
                    'images/intro.png',
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    'الفلوس راحت فين؟',
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
                    icon: item.icon,
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
