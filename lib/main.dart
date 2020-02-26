import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//my imports

import './infrastructure/ui/screens/analysis_screen.dart';
import './infrastructure/ui/screens/tabs_screen.dart';
import './infrastructure/ui/screens/intro_screen.dart';
import './infrastructure/ui/screens/home_screen.dart';
import './infrastructure/ui/screens/settings_screen.dart';
import './infrastructure/ui/screens/settings_choice_screen.dart';
import './infrastructure/ui/screens/about_screen.dart';
import './infrastructure/ui/screens/category_list_screen.dart';
import './infrastructure/ui/screens/filters_screen.dart';
import './constants.dart';

import './domain/managers/ui_manager.dart';
import './domain/managers/database_manager.dart';
import './domain/managers/localization_manager.dart';
import './domain/managers/filters_manager.dart';
import './domain/managers/notifications_manager.dart';

// TODO: REFACTOR AND CLEAN THE CODE

void main() {
  // Run the app
  runApp(MyApp());

  // Read from the Database immediately after creating the app.
  DatabaseManager();

  // Initialize Notifications Manager
  NotificationsManger();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UiManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => LocalizationManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => FiltersManager(),
          ),
        ],
        child: Consumer<LocalizationManager>(
          builder: (context, localeManager, child) {
            return MaterialApp(
              locale: localeManager.preferredLocale,
              localizationsDelegates: [
                FlutterI18nDelegate(
                    forcedLocale: localeManager.preferredLocale,
                    useCountryCode: false,
                    fallbackFile: 'en.json',
                    path: 'flutter_i18n'),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en'),
                const Locale('ar'),
              ],
              debugShowCheckedModeBanner: false,
              title: kTitleAr,
              theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.amber,
                fontFamily: 'Tajawal',
              ),
              routes: {
                kHomeScreenID: (context) => HomeScreen(),
                kAnalysisScreenID: (context) => AnalysisScreen(),
                kIntroScreenID: (context) => IntroScreen(),
                kAboutScreenID: (context) => AboutScreen(),
                kSettingsScreenID: (context) => SettingsScreen(),
                kSettingsChoiceScreenID: (context) => SettingsChoiceScreen(),
                kTabsScreenID: (context) => TabsScreen(),
                kCategoryListScreenID: (context) => CategoryListScreen(),
                kFiltersScreenID: (context) => FiltersScreen(),
              },
              initialRoute: kIntroScreenID,
            );
          },
        ));
  }
}
