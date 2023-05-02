import 'package:flutter/material.dart';

class ThemeModel {
  final String name;
  final Color? color;
  final ThemeMode? mode;
  final IconData? icon;

  const ThemeModel({
    required this.name,
    this.color,
    this.mode,
    this.icon,
  });

  static final light = generateTheme(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.green,
  );

  static ThemeData generateTheme({
    required Brightness brightness,
    required Color colorSchemeSeed,
  }) {
    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorSchemeSeed: colorSchemeSeed,
    );
  }

  static List<ThemeModel> themes = const [
    ThemeModel(
      name: 'System',
      mode: ThemeMode.system,
      icon: Icons.phone_android,
    ),
    ThemeModel(
      name: 'Light',
      mode: ThemeMode.light,
      icon: Icons.light_mode,
    ),
    ThemeModel(
      name: 'Blue',
      color: Colors.blue,
    ),
    ThemeModel(
      name: 'Red',
      color: Colors.red,
    ),
    ThemeModel(
      name: 'Pink',
      color: Colors.pink,
    ),
    ThemeModel(
      name: 'Purple',
      color: Colors.purple,
    ),
    ThemeModel(
      name: 'DeepPurple',
      color: Colors.deepPurple,
    ),
    ThemeModel(
      name: 'Indigo',
      color: Colors.indigo,
    ),
    ThemeModel(
      name: 'LightBlue',
      color: Colors.lightBlue,
    ),
    ThemeModel(
      name: 'Cyan',
      color: Colors.cyan,
    ),
    ThemeModel(
      name: 'Teal',
      color: Colors.teal,
    ),
    ThemeModel(
      name: 'LightGreen',
      color: Colors.lightGreen,
    ),
    ThemeModel(
      name: 'Lime',
      color: Colors.lime,
    ),
    ThemeModel(
      name: 'Yellow',
      color: Colors.yellow,
    ),
    ThemeModel(
      name: 'Amber',
      color: Colors.amber,
    ),
    ThemeModel(
      name: 'Orange',
      color: Colors.orange,
    ),
    ThemeModel(
      name: 'DeepOrange',
      color: Colors.deepOrange,
    ),
    ThemeModel(
      name: 'Brown',
      color: Colors.brown,
    ),
    ThemeModel(
      name: 'Grey',
      color: Colors.grey,
    ),
    ThemeModel(
      name: 'BlueGrey',
      color: Colors.blueGrey,
    ),
  ];
}