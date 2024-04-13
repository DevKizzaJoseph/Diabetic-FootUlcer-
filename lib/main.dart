import 'package:dole/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:dole/screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Insole',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(), // Provide currentIndex parameter with a value of 0
    );
  }
}
