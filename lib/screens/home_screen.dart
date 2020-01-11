import 'package:flutter/material.dart';
import '../screens/add_transaction_screen.dart';
import '../widgets/chart_widget.dart';
import '../widgets/transactions_list_widget.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
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
          TransactionsList(),
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
