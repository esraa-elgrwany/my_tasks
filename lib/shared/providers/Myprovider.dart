import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  String languageCode="en";
  ThemeMode modeApp=ThemeMode.light;

  changeLanguage(String langCode){
    languageCode=langCode;
    notifyListeners();
  }

  changeMode(ThemeMode mode){
    modeApp=mode;
    notifyListeners();
  }
}