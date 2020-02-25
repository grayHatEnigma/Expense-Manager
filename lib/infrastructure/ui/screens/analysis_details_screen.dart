import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../../constants.dart';
import '../widgets/empty_list_widget.dart';
import '../../../domain/managers/ui_manager.dart';
import '../../../domain/models/category.dart';

class AnalysisDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiManager = Provider.of<UiManager>(context);

    final categoryMap = uiManager.analysisTransactionsPerCategory();
    return Container(
      padding: EdgeInsets.all(15),
      child: categoryMap.length == 0
          ? EmptyListWidget(
              textToDisplay: kNoRecords,
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 5 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemBuilder: (_, index) {
                return CategoryCardWidget(categoryMap.keys.toList()[index],
                    categoryMap.values.toList()[index]);
              },
              itemCount: categoryMap.length,
            ),
    );
  }
}

class CategoryCardWidget extends StatelessWidget {
  final Category _category;
  final _transactionsList;

  const CategoryCardWidget(this._category, this._transactionsList);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, kCategoryListScreenID,
          arguments: _transactionsList),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: _category.color.withOpacity(0.95),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                FlutterI18n.translate(context, _category.title),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
