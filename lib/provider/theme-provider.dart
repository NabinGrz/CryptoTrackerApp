import 'package:cryptotrackerapp/localstorage/local-storage.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode themeMode;
  ThemeProvider(String theme) {
    if (theme == "light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
  void changeTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      await LocalStorage.setTheme("dark");
    } else {
      themeMode = ThemeMode.light;
      await LocalStorage.setTheme("light");
    }
    notifyListeners();
  }
}
