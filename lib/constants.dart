//flutter core
import 'package:flutter/material.dart';

// Values and Widgets

final kTitle = 'الفلوس راحت فين؟';

final kNoTransactionsText = Center(
  child: Text(
    'مضفتش أي مصروفات لسه!',
    textDirection: TextDirection.rtl,
    style: kEmptyListTextStyle,
  ),
);

// Styles

final kChartTextStyle = TextStyle(color: Colors.white, fontSize: 15);

final kEmptyListTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.black38,
  letterSpacing: 0.25,
);

final kTitleTextStyle = TextStyle(
  fontSize: 28,
  color: Colors.white,
);
