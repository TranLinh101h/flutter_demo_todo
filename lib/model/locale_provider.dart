import 'package:flutter/material.dart';
import 'package:demo/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  String langCode = 'en';
  String get _langCode => langCode;
  Locale get locale => Locale(langCode);

  Future<void> setLocale(String _langCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('_locale', _langCode);

    // if (!L10n.all.contains(locale)) return;

    langCode = _langCode;
    notifyListeners();
  }

  Future<void> fetchLocale() async {
    var pref = await SharedPreferences.getInstance();

    langCode = await pref.getString('_locale') ?? 'en';
    print('---code: $langCode---');
  }

  void clearLocale() {
    // _locale = null;
    notifyListeners();
  }
}
