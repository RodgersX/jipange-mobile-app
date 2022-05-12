import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const themeStatus = 'THEMESTATUS';

  // save the bool value
  setDarkTheme(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, val);
  }

  // get the bool value
  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? false;
  }
}

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePref = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool val) {
    darkThemePref.setDarkTheme(val);
    notifyListeners();
  }

  void switchTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }
}

class Styles {
  static ThemeData themeData(bool isdarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor:
          isdarkTheme ? const Color.fromRGBO(37, 37, 37, 1) : Colors.white,
      accentColor: isdarkTheme ? Colors.white : Colors.black,
      buttonColor: isdarkTheme
          ? const Color.fromRGBO(238, 202, 255, 1)
          : const Color.fromRGBO(70, 30, 88, 1),
      hintColor: Colors.grey[500],
    );
  }
}
