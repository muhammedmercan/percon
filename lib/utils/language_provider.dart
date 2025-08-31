import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  final Function(Locale) _changeLanguage;

  LanguageProvider(this._changeLanguage);

  void changeLanguage(Locale locale) {
    _changeLanguage(locale);
  }
}
