import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsManger {
  // Singleton instance from Filters Manager class.
  static final instance = NotificationsManger._();
  factory NotificationsManger() => instance;
  NotificationsManger._() {
    // initialize notifications settings
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initialize();
  }
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Time _scheduleTime = Time(4, 0, 0);
  void _initialize() async {
    // initialise the plugin.
    var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosSettings = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    var initializationSettings =
        InitializationSettings(androidSettings, iosSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    scheduleAtParticularTime();
  }

  Future scheduleAtParticularTime() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.showDailyAtTime(
        1,
        'سجل مصاريفك',
        'لا تنسى تسجيل مصاريفك أولاً بأول',
        _scheduleTime,
        platformChannelSpecifics);
  }
}
