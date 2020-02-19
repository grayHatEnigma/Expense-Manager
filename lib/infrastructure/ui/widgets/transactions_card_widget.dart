import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';

import '../../../domain/managers/ui_manager.dart';
import '../../../domain/models/transaction.dart';
import './transaction_tile_widget.dart';
import '../../../constants.dart';

class TransactionsCard extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionsCard(this.transactions);
  @override
  Widget build(BuildContext context) {
    final uiManager = Provider.of<UiManager>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
            iconColor: Theme.of(context).primaryColor,
            collapseIcon: Icons.list,
            expandIcon: Icons.arrow_drop_up,
            headerAlignment: ExpandablePanelHeaderAlignment.center),
        header: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Icon(
                Icons.attach_money,
                color: Theme.of(context).accentColor,
              ),
              FittedBox(
                child: Text(
                  formatDate(transactions.first.date, [
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
              ),
              Container(
                width: 100,
                child: FittedBox(
                  child: Text(
                    '$kDailyExpenses: ${uiManager.calculateTotalSpending(transactions).toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
        ),
        collapsed: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            elevation: 3,
            child: Column(
              children: transactions.map((tx) {
                return TransactionTile(
                    transaction: tx,
                    deleteCallback: () {
                      uiManager.deleteTransaction(id: tx.id);
                    });
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
