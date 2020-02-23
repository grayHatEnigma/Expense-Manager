import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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
    final myLocale = Localizations.localeOf(context);
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
              CardDateWidget(myLocale: myLocale, transactions: transactions),
              Container(
                width: 100,
                child: FittedBox(
                  child: Text(
                    '${FlutterI18n.translate(context, kDailyExpenses)}: ${uiManager.calculateTotalSpending(transactions).toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              )
            ],
          ),
        ),
        collapsed: Card(
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
    );
  }
}

// Widget for displaying card date
class CardDateWidget extends StatelessWidget {
  const CardDateWidget({
    @required this.myLocale,
    @required this.transactions,
  });

  final Locale myLocale;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Image.asset(
            'images/list.png',
            height: 30,
            width: 30,
          ),
        ),
        FittedBox(
          child: Text(
            DateFormat.yMMMEd(myLocale.languageCode)
                .format(transactions.first.date),
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
