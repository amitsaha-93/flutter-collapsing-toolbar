
import 'package:flutter/material.dart';
import 'package:iota/app.dart';
import 'package:iota/database/app_preferences.dart';
import 'package:iota/models/user.dart';
import 'package:iota/services/base_services.dart';
import 'package:iota/utils/common_utils.dart';
import 'package:iota/utils/constant.dart';
import 'package:provider/provider.dart';

class AppModel with ChangeNotifier {

  Map<String, dynamic> appConfig;
  bool isLoading = true;
  String message;
  bool darkTheme = false;
  String locale = AppConstants.LANGUAGE_SPANISH;
  static var scaffoldKey;
  LoginDetails loginDetails;
  String _languageCode = "";
  AppPreferences appPreferences = new AppPreferences();
  Services _service = Services();
  String CountNotice = "0";

  void changeLanguage() async {
    String locale = await appPreferences.getLanguageCode();
    if (locale.isEmpty) {
      appPreferences.setLanguageCode(this.locale);
      locale = this.locale;
    }
    this.locale = locale;
    notifyListeners();
  }

  void updateTheme(bool theme) {
    darkTheme = theme;
    notifyListeners();
  }
}


class App {
  Map<String, dynamic> appConfig;
  App(this.appConfig);
}
