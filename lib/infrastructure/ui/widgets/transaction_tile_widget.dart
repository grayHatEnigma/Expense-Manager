import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

//my imports
import '../../../domain/models/transaction.dart';
import '../../../constants.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final Function deleteCallback;

  TransactionTile({@required this.transaction, @required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // force the tile to be left to right aligned
        textDirection: TextDirection.ltr,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: transaction.category.color,
            radius: 35,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text(
                  '${transaction.amount.toStringAsFixed(2)} ${FlutterI18n.translate(context, kMoneyPrefix)}',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: FittedBox(
              child: Text(
                transaction.title,
                style: TextStyle(
                    fontSize: 15,
                    color: transaction.category.color,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onLongPress: deleteCallback,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Icon(
                  Icons.delete,
                  size: 25,
                  color: Colors.red,
                ),
                if (mediaQueryData.size.width > 450)
                  Text(
                    FlutterI18n.translate(context, kDeleteButtonHint),
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
