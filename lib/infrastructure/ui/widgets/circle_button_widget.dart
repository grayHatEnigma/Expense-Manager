import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final String title;
  final IconData icon;

  const CircleButton({this.onPressed, this.color, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        radius: isLandScape ? 45 : 70,
        backgroundColor: color,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
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

/*

 Expanded(
              child: Icon(
                icon,
                color: Colors.white,
                size: 27,
              ),
            ),


             Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
 */
