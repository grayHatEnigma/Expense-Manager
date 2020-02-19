import 'package:flutter/material.dart';

class NavigationListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;

  NavigationListTile({this.title, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Icon(
              icon,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
