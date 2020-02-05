//flutter core

import 'package:expense_manager/infrastructure/ui/widgets/transactions_card_widget.dart';
import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';

// my imports
import './transaction_tile_widget.dart';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/domain/manager_ui_contract.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ManagerUiContract>(context);
    final groupedTransactions = manager.groupedTransactionsByDate;
    final length = groupedTransactions.length;
    return length == 0
        ? Expanded(
            child: Center(
              child: Text(
                'No Transaction added yet!',
                style: kEmptyListTextStyle,
              ),
            ),
          )
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return TransactionsCard(groupedTransactions[index]);
                },
                itemCount: length,
              ),
            ),
          );
  }
}

/*
Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return TransactionTile(
                      transaction: transactions[index],
                      deleteCallback: () {
                        manager.deleteTransaction(index: index);
                      });
                },
                itemCount: length,
              ),
            ),
          );
 */
