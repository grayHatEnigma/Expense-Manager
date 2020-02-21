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
    final locale = Localizations.localeOf(context);
    bool isLtr = locale.languageCode == 'en';
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
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
            Row(
              children: <Widget>[
                if (isLtr)
                  Icon(
                    isLtr ? Icons.chevron_right : Icons.chevron_left,
                    color: Colors.grey,
                    size: 15,
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
              ],
            ),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: transaction.category.color,
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: FittedBox(
                      child: Text(
                        '${transaction.amount.toStringAsFixed(1)} ${FlutterI18n.translate(context, kMoneyPrefix)}',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                if (!isLtr)
                  Icon(
                    isLtr ? Icons.chevron_right : Icons.chevron_left,
                    color: Colors.grey,
                    size: 15,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
