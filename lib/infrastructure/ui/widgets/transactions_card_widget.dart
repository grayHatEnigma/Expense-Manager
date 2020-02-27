import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
            iconColor: Theme.of(context).primaryColor,
            collapseIcon: Icons.list,
            expandIcon: Icons.arrow_drop_up,
            headerAlignment: ExpandablePanelHeaderAlignment.center),
        header: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              CardDateWidget(
                  myLocale: myLocale, cardDate: transactions.first.date),
              Container(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${FlutterI18n.translate(context, kDailyExpenses)}: ${uiManager.calculateTotalAmount(uiManager.getExpensesOnly(transactions)).toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
              )
            ],
          ),
        ),
        collapsed: Card(
          color: Colors.white,
          elevation: 4,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: transactions.map((tx) {
                return TransactionTile(
                    transaction: tx,
                    deleteCallback: () {
                      uiManager.deleteTransaction(id: tx.id);
                    });
              }).toList()),
        ),
      ),
    );
  }
}

// Widget for displaying card date
class CardDateWidget extends StatelessWidget {
  const CardDateWidget({
    @required this.myLocale,
    @required this.cardDate,
  });

  final Locale myLocale;
  final DateTime cardDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          'images/list.png',
          height: 27,
          width: 27,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              DateFormat.yMMMEd(myLocale.languageCode).format(cardDate),
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }
}
/*
Expandable Code
//
Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
            iconColor: Theme.of(context).primaryColor,
            collapseIcon: Icons.list,
            expandIcon: Icons.arrow_drop_up,
            headerAlignment: ExpandablePanelHeaderAlignment.center),
        header: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              CardDateWidget(
                  myLocale: myLocale, cardDate: transactions.first.date),
              Container(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${FlutterI18n.translate(context, kDailyExpenses)}: ${uiManager.calculateTotalAmount(uiManager.getExpensesOnly(transactions)).toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
              )
            ],
          ),
        ),
        collapsed: Card(
          color: Colors.white,
          elevation: 4,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: transactions.map((tx) {
                return TransactionTile(
                    transaction: tx,
                    deleteCallback: () {
                      uiManager.deleteTransaction(id: tx.id);
                    });
              }).toList()),
        ),
      ),
    );

 */
//

/*
No Expansion Code
//
return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: Container(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                CardDateWidget(
                    myLocale: myLocale, cardDate: transactions.first.date),
                Container(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${FlutterI18n.translate(context, kDailyExpenses)}: ${uiManager.calculateTotalAmount(uiManager.getExpensesOnly(transactions)).toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ),
                )
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 4,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: transactions.map((tx) {
                  return TransactionTile(
                      transaction: tx,
                      deleteCallback: () {
                        uiManager.deleteTransaction(id: tx.id);
                      });
                }).toList()),
          ),
        ],
      )),
    );
 */
