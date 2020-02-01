//flutter core
import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';

//my imports
import './domain/transactions_data.dart';
import './infrastructure/ui/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionsData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Manager',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Tajawal',
        ),
        home: MyHomePage(title: 'Expense Manager'),
      ),
    );
  }
}
