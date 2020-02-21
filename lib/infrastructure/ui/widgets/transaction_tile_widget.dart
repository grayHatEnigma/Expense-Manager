import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//my imports
import '../../../domain/models/transaction.dart';
import '../../../constants.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final Function deleteCallback;

  TransactionTile({@required this.transaction, @required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
          caption: FlutterI18n.translate(context, kDeleteButtonHint),
          color: Colors.red,
          icon: Icons.delete,
          onTap: deleteCallback,
        ),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
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
            CircleAvatar(
              backgroundColor: transaction.category.color,
              radius: 30,
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
          ],
        ),
      ),
    );
  }
}

/*

Delete Button

    GestureDetector(
            onLongPress: deleteCallback,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Icon(
                  Icons.cancel,
                  size: 22,
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



 */
