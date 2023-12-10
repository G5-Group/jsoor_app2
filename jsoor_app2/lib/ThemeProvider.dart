
import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkModeEnabled = false;


  void toggleTheme() {
    isDarkModeEnabled = !isDarkModeEnabled;
    notifyListeners();
  }
}
