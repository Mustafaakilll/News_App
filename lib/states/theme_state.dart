import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeState with ChangeNotifier {
  bool isLightTheme;
  ThemeState({required this.isLightTheme});

  Future<void> toggleThemeData() async {
    final settings = await Hive.openBox('theme');
    await settings.put('isLightTheme', !isLightTheme);
    isLightTheme = !isLightTheme;
    notifyListeners();
  }

  ThemeData themeData() {
    final theme = isLightTheme == true ? ThemeData.light() : ThemeData.dark();
    return theme;
  }
}
