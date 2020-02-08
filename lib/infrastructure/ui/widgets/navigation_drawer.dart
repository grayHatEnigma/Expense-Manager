import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 60,
        color: Colors.purple,
        child: Column(
          children: <Widget>[
            IconButton(
              iconSize: 40,
              icon: Icon(
                Icons.assessment,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/analysis');
              },
            ),
            IconButton(
              iconSize: 40,
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                //TODO add functionality to edit plan
                print('edit button pressed');
              },
            ),
            IconButton(
              iconSize: 40,
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
              onPressed: () {
                //TODO add info screen (about)
                print('info button pressed');
              },
            ),
          ],
        ),
      ),
    );
  }
}
