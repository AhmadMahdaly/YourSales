import 'package:flutter/material.dart';
import 'package:your_sales/core/init/initializer.dart';
import 'package:your_sales/features/my_app/my_app.dart';

void main() async {
  await initializeApp();
  runApp(const MyApp());
}
