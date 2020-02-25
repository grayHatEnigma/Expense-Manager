import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

class EmptyListWidget extends StatelessWidget {
  final String textToDisplay;

  const EmptyListWidget({this.textToDisplay});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.library_books,
              color: Colors.black38,
              size: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              FlutterI18n.translate(context, textToDisplay),
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black38,
                letterSpacing: 0.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
