//flutter core
import 'package:flutter/material.dart';

//my imports
import '../constants.dart';

class ChartBarWidget extends StatelessWidget {
  final double amount;
  final String weekDay;
  final double percentage;

  ChartBarWidget({this.amount, this.weekDay, this.percentage});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: constrains.maxHeight * 0.075),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: constrains.maxHeight * 0.10,
                child: FittedBox(
                  child: Text(
                    weekDay,
                    style: kChartTextStyle,
                  ),
                ),
              ),
              SizedBox(
                height: constrains.maxHeight * 0.05,
              ),
              Container(
                height: constrains.maxHeight * 0.5,
                width: 13,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            (15),
                          ),
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: percentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          border: Border.all(
                              width: 1, color: Theme.of(context).accentColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              (15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: constrains.maxHeight * 0.05,
              ),
              Container(
                height: constrains.maxHeight * 0.15,
                child: FittedBox(
                  child: Text(
                    '${amount.toStringAsFixed(0)} EG ',
                    style: kChartTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
