import '../../constants.dart';

class NavigationModel {
  final String title;
  final String iconPath;
  final String destination;

  NavigationModel({this.destination, this.title, this.iconPath});
}

List<NavigationModel> navigationItems = [
  NavigationModel(
      title: kNavAnalysis,
      iconPath: 'images/analysis.png',
      destination: kTabsScreenID),
  NavigationModel(
      title: kNavSettings,
      iconPath: 'images/settings.png',
      destination: kSettingsScreenID),
  NavigationModel(
      title: kNavAbout,
      iconPath: 'images/about.png',
      destination: kAboutScreenID),
];
