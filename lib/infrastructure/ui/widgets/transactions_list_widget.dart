//flutter core
import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';

// my imports
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/domain/manager_ui_contract.dart';
import '../widgets/transaction_tile_widget.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<ManagerUiContract>(context);
    final transactions = transactionsData.transactionsList;
    final length = transactions.length;
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
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TransactionTile(
                    transaction: transactions[index],
                    deleteCallback: () {
                      transactionsData.deleteTransaction(index: index);
                    });
              },
              itemCount: length,
            ),
          );
  }
}
