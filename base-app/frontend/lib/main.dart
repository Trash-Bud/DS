import 'package:flutter/material.dart';
import 'package:frontend/themes/base_theme.dart';

import 'widgets/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAERSK e-commerce',
      theme: baseTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Dashboard(
      loggedUserName: "",
    ));
  }
}
