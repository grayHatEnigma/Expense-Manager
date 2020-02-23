import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../domain/models/transaction.dart';

class CategoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionsList =
        ModalRoute.of(context).settings.arguments as List<Transaction>;
    final category = transactionsList.first.category;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${FlutterI18n.translate(context, kCategoryListTitle)} ${FlutterI18n.translate(context, category.title)}',
          ),
        ),
        body: ListView.builder(
          itemBuilder: (_, index) {
            return TransactionChip(
              transaction: transactionsList[index],
            );
          },
          itemCount: transactionsList.length,
        ),
      ),
    );
  }
}

class TransactionChip extends StatelessWidget {
  final Transaction transaction;

  const TransactionChip({this.transaction});
  @override
  Widget build(BuildContext context) {
    final myLocale = Localizations.localeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Card(
        color: transaction.category.color,
        child: ListTile(
          leading: Icon(
            Icons.monetization_on,
            color: Colors.white,
          ),
          title: Text(
            transaction.title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            DateFormat.yMMMEd(myLocale.languageCode).format(transaction.date),
            style: TextStyle(color: Colors.white),
          ),
          trailing: Text(
            transaction.amount.toStringAsFixed(1),
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
