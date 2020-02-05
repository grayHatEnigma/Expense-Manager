import 'package:flutter/material.dart';

//my imports
import 'package:expense_manager/domain/models/transaction.dart';

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
        children: <Widget>[
          CircleAvatar(
            backgroundColor: transaction.categoryColor,
            radius: 40,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text(
                  '${transaction.amount.toStringAsFixed(2)} ج.م',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 17,
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
                    fontSize: 17,
                    color: transaction.categoryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onLongPress: deleteCallback,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (mediaQueryData.size.width > 450)
                  const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                const Icon(
                  Icons.delete,
                  size: 25,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}