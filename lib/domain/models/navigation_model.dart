import 'package:flutter/material.dart';

import '../../constants.dart';

class NavigationModel {
  final String title;
  final IconData icon;
  final String destination;

  NavigationModel({this.destination, this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(
      title: kNavAnalysis,
      icon: Icons.insert_chart,
      destination: kAnalysisScreenID),
  NavigationModel(
      title: kNavSettings,
      icon: Icons.settings,
      destination: kSettingsScreenID),
  NavigationModel(
      title: kNavAbout, icon: Icons.info, destination: kAboutScreenID),
];
