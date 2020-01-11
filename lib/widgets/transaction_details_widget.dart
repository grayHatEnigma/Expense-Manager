import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:date_format/date_format.dart';

class TransactionDetails extends StatelessWidget {
  final Transaction transaction;
  TransactionDetails({this.transaction});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: FittedBox(
              child: Text(
                transaction.title,
                style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Text(
            formatDate(transaction.date, [
              DD,
              ' , ',
              dd,
              '/',
              mm,
              '/',
              yy,
            ]),
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
