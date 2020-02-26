import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../../domain/managers/ui_manager.dart';
import '../../../domain/managers/filters_manager.dart';
import '../../../domain/models/transaction.dart';
import './transaction_tile_widget.dart';
import '../../../constants.dart';

class TransactionsCard extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionsCard(this.transactions);

  @override
  Widget build(BuildContext context) {
    final uiManager = Provider.of<UiManager>(context);
    final filtersManager = Provider.of<FiltersManager>(context);
    final myLocale = Localizations.localeOf(context);
    //
    // Filter Manager to get Filters State
    // and filters the lists according to it

    // filter transactions according to filters state in filters manager.
    final filteredTransactions = filtersManager.filter(transactions);

    return filteredTransactions.length == 0
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: ExpandablePanel(
              // todo: fix a bug
              // There is a bug here
              // if you use controller the icon will not change
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
                    CardDateWidget(
                        myLocale: myLocale, transactions: transactions),
                    Container(
                      width: 100,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${FlutterI18n.translate(context, kDailyExpenses)}: ${uiManager.calculateTotalAmount(uiManager.getExpensesOnly(transactions)).toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              collapsed: Card(
                elevation: 3,
                child: Column(
                  children: filteredTransactions.map((tx) {
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
          fit: BoxFit.scaleDown,
          child: Text(
            DateFormat.yMMMEd(myLocale.languageCode)
                .format(transactions.first.date),
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
