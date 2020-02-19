import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final String title;
  final IconData icon;

  const CircleButton({this.onPressed, this.color, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 60,
        backgroundColor: color,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Icon(
                icon,
                color: Colors.white,
                size: 27,
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
