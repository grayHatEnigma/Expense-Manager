import 'package:expense_manager/models/transactions_data.dart';
import 'package:flutter/material.dart';
import '../screens/add_transaction_screen.dart';
import '../widgets/chart_widget.dart';
import '../widgets/transactions_list_widget.dart';
import 'package:provider/provider.dart';
import '../models/transactions_data.dart';
import '../constants.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    final length =
        Provider.of<TransactionsData>(context).transactionsList.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              /// open modal bottom sheet
              addNewTransaction(context);
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          /// open modal bottom sheet
          addNewTransaction(context);
        },
      ),
      body: Column(
        children: <Widget>[
          Chart(),
          length == 0
              ? Expanded(
                  child: Center(
                    child: Text(
                      'No Transaction added yet!',
                      style: kEmptyListTextStyle,
                    ),
                  ),
                )
              : TransactionsList(),
        ],
      ),
    );
  }

  void addNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddTransaction();
        });
  }
}
