//flutter core
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'dart:io';
import 'package:provider/provider.dart';

//my imports
import '../screens/add_transaction_screen.dart';
import '../widgets/chart_widget.dart';
import '../widgets/transactions_list_widget.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/adaptive_switch_widget.dart';
import '../../../constants.dart';
import '../../../domain/managers/localization_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final localeManager = Provider.of<LocalizationManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            kTitle,
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              // open modal bottom sheet
              addNewTransaction(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              color: Colors.white,
            ),
//            icon: Image.asset(
//              'images/ar.png',
//              height: 30,
//              width: 30,
//            ),
            onPressed: () {
              print('Toggle App Language');
              Localizations.localeOf(context) == Locale('en')
                  ? localeManager.setPreferredLocale = Locale('ar')
                  : localeManager.setPreferredLocale = Locale('en');
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Platform.isIOS
          ? Container(
              height: 80,
            )
          : FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 30,
              ),
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () {
                // open modal bottom sheet
                addNewTransaction(context);
              },
              mini: true,
            ),
      drawer: NavigationDrawer(),
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
      },
      isScrollControlled: true,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
    );
  }

  // This method will be called when the device orientation changes
  // so I re-initialize _showChart variable to false each time it is called.
  @override
  void didChangeDependencies() {
    _showChart = false;
    super.didChangeDependencies();
  }
}
