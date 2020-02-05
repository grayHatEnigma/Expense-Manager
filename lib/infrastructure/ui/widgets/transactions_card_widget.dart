import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';

import 'package:expense_manager/domain/manager_ui_contract.dart';
import 'package:expense_manager/domain/models/transaction.dart';
import './transaction_tile_widget.dart';

class TransactionsCard extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionsCard(this.transactions);
  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ManagerUiContract>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    formatDate(transactions[0].date, [
                      DD,
                      ', ',
                      dd,
                      '/',
                      mm,
                      '/',
                      yy,
                    ]),
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    'Expenses: ${calculateTotalSpending(transactions).toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 0.75,
              width: double.infinity,
              child: Container(
                color: Colors.grey,
              ),
            ),
            Column(
              children: transactions.map((tx) {
                return TransactionTile(
                    transaction: tx,
                    deleteCallback: () {
                      manager.deleteTransaction(id: tx.id);
                    });
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotalSpending(List<Transaction> list) {
    double sum = 0;
    list.forEach((tx) => sum += tx.amount);
    return sum;
  }
}
