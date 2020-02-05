import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';

import 'package:expense_manager/domain/manager_ui_contract.dart';
import 'package:expense_manager/domain/models/transaction.dart';
import 'package:expense_manager/infrastructure/ui/widgets/transaction_tile_widget.dart';

class TransactionsCard extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionsCard(this.transactions);
  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ManagerUiContract>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
              child: Text(
                formatDate(transactions[0].date, [
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
}
