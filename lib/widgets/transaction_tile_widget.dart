import '../models/transaction.dart';
import 'package:flutter/material.dart';
import './transaction_details_widget.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final Function deleteCallback;

  TransactionTile({this.transaction, this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 48,
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
          TransactionDetails(
            transaction: transaction,
          ),
          GestureDetector(
            onLongPress: deleteCallback,
            child: Icon(
              Icons.delete,
              size: 25,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
