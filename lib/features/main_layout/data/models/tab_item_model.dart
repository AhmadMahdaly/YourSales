import 'package:flutter/material.dart';

class TabItemModel {
  const TabItemModel({
    required this.label,
    required this.icon,
    required this.page,
  });
  final String label;
  final String icon;
  final Widget page;
}
