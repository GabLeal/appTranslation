import 'package:flutter/material.dart';

import 'app/view_translation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _darkTheme = ThemeData(
    accentColor: Colors.blue[800],
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
  );

  ThemeData _lightTheme = ThemeData(
    accentColor: Colors.blue,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    primaryColor: Colors.blue,
  );

  bool _light = true;

  Widget switchTheme() {
    return Row(
      children: [
        Switch(
            activeColor: Theme.of(context).backgroundColor,
            value: _light,
            onChanged: (toggle) {
              setState(() {
                _light = toggle;
              });
            }),
        Icon(_light ? Icons.wb_sunny : Icons.nightlight_round)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: _light ? _lightTheme : _darkTheme,
      home: ViewTranslation(switchTheme: switchTheme()),
    );
  }
}
