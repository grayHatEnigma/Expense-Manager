import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';

// my imports
import '../../../constants.dart';
import '../../../domain/managers/ui_manager.dart';
import './transactions_card_widget.dart';
import './empty_list_widget.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiManager = Provider.of<UiManager>(context);
    final groupedTransactions = uiManager.groupedTransactionsByDate;
    final length = groupedTransactions.length;
    return length == 0
        ? Expanded(
            child: EmptyListWidget(),
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
