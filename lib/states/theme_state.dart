import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeState with ChangeNotifier {
  bool isLightTheme;
  ThemeState({this.isLightTheme});

  toggleThemeData() async {
    final settings = await Hive.openBox("theme");
    settings.put("isLightTheme", !isLightTheme);
    isLightTheme = !isLightTheme;
    notifyListeners();
  }

  ThemeData themeData() {
    final theme = isLightTheme == true ? ThemeData.light() : ThemeData.dark();
    return theme;
  }
}
