import '../widgets/transaction_tile_widget.dart';
import 'package:flutter/material.dart';

import '../models/transactions_data.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<TransactionsData>(context);
    final transactions = transactionsData.transactionsList;
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return TransactionTile(
              transaction: transactions[index],
              deleteCallback: () {
                transactionsData.deleteTransaction(index);
              });
        },
        itemCount: transactions.length,
      ),
    );
  }
}
