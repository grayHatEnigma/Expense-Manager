import 'package:flutter/material.dart';

import '../screens/add_transaction_screen.dart';
import '../widgets/chart_widget.dart';
import '../widgets/transactions_list_widget.dart';
import '../widgets/adaptive_switch_widget.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      body: SafeArea(
        child: isLandscape
            ? Column(
                children: [
                  AdaptiveSwitch(
                    switchState: (newVal) {
                      setState(() {
                        _showChart = newVal;
                      });
                    },
                  ),
                  _showChart
                      ? Container(
                          height: mediaQuery.size.height * 0.45,
                          child: Chart(),
                        )
                      : TransactionsList()
                ],
              )
            : Column(
                children: [
                  Container(
                    height: mediaQuery.size.height * 0.25,
                    child: Chart(),
                  ),
                  TransactionsList(),
                ],
              ),
      ),
    );
  }

  // This to open the Add new transaction screen.
  void addNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddTransaction();
        });
  }

  /// Stateful widget life cycle debugging

  // This method will be called when the device orientation changes
  // so I re-initialize _showChart variable to false .
  @override
  void didChangeDependencies() {
    _showChart = false;
    print('didChangeDependencies');
    super.didChangeDependencies();
  }
}
