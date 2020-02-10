import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';

// my imports
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/domain/manager_ui_contract.dart';
import './transactions_card_widget.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ManagerUiContract>(context);
    final groupedTransactions = manager.groupedTransactionsByDate;
    final length = groupedTransactions.length;
    return length == 0
        ? Expanded(child: kNoTransactionsText)
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
