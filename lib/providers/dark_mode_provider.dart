import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeProvider with ChangeNotifier {
  bool isdark = false;

  switchmode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isdark = !isdark;
    prefs.setBool("mood", isdark);
    notifyListeners();
  }

  getmode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isdark = prefs.getBool("mood") ?? false;
    notifyListeners();
  }
}
