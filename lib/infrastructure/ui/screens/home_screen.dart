//flutter core
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//  void initialize() async {
//    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//    // initialise the plugin.
//    var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//    var iosSettings = IOSInitializationSettings(
//      requestSoundPermission: true,
//      requestBadgePermission: true,
//      requestAlertPermission: true,
//    );
//
//    var initializationSettings =
//        InitializationSettings(androidSettings, iosSettings);
//    await flutterLocalNotificationsPlugin.initialize(
//      initializationSettings,
//      onSelectNotification: onSelectNotification,
//    );
//  }

//  Future onSelectNotification(payload) async {
//    print(payload);
//    return true;
//  }
//  Future _showNotificationWithDefaultSound() async {
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.Max, priority: Priority.High);
//    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//    var platformChannelSpecifics = new NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//      0,
//      'Learn Local Notification',
//      'A Local Notification On Button Click',
//      platformChannelSpecifics,
//      payload: 'Default_Sound',
//    );
//  }

//  Future scheduleAtParticularTime(Time timee) async {
//    var time = Time(timee.hour, timee.minute, timee.second);
//
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//        'repeatDailyAtTime channel id',
//        'repeatDailyAtTime channel name',
//        'repeatDailyAtTime description');
//    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//    var platformChannelSpecifics = new NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    flutterLocalNotificationsPlugin.showDailyAtTime(1, 'سجل مصاريفك',
//        'لا تنسى تسجيل مصاريفك أولاً بأول', time, platformChannelSpecifics,
//        payload: 'hi this is me');
//    print('scheduled');
//  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final localeManager = Provider.of<LocalizationManager>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          FlutterI18n.translate(context, kTitle),
          textAlign: TextAlign.center,
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
              Icons.filter_list,
              color: Colors.white,
            ),
            onPressed: () {
              // open filters screen
              Navigator.pushNamed(context, kFiltersScreenID);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              color: Colors.white,
            ),
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
