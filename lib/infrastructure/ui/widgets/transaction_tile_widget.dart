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
    bool isIncome = transaction.amount > 0;
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        transaction.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: transaction.category.color,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        FlutterI18n.translate(
                            context, transaction.category.title),
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    'images/${isIncome ? 'income.png' : 'expenses.png'}',
                    height: 22,
                    width: 22,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: transaction.category.color,
                  radius: 28,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: FittedBox(
                      child: Text(
                        '${transaction.amount.abs().toStringAsFixed(1)}',
                        style: TextStyle(
                            fontSize: 16,
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
