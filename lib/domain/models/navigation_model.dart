import 'package:flutter/material.dart';

class NavigationModel {
  final String title;
  final IconData icon;
  final String destination;

  NavigationModel({this.destination, this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(
      title: 'تحليل المصاريف',
      icon: Icons.insert_chart,
      destination: '/analysis'),
  NavigationModel(
    title: 'الإعدادت',
    icon: Icons.settings,
  ),
  NavigationModel(title: 'عن التطبيق', icon: Icons.info),
  NavigationModel(title: 'قيّم التطبيق', icon: Icons.star),
];
