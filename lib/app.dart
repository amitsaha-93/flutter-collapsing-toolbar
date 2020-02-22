import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iota/database/app_preferences.dart';
import 'package:iota/utils/constant.dart';
import 'package:provider/provider.dart';

import 'generated/i18n.dart';
import 'models/app.dart';
import 'views/home/home_view.dart';
import 'views/home/home_view_model.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> with AfterLayoutMixin {
  static BuildContext appContext;
  final _app = AppModel();
  AppPreferences appPreferences = new AppPreferences();

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    appContext = context;
    return ChangeNotifierProvider<AppModel>.value(
      value: _app,
      child: Consumer<AppModel>(
        builder: (context, value, child) {
          value.isLoading = false;

          if (value.isLoading) {
            return Container(
              color: Theme.of(context).backgroundColor,
            );
          }

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(builder: (context) => HomeViewModel()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: new Locale(Provider.of<AppModel>(context).locale, ""),
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              localeListResolutionCallback: S.delegate.listResolution(
                  fallback: const Locale(AppConstants.LANGUAGE_ENGLISH, '')),
              home: HomeView(),
            ),
          );
        },
      ),
    );
  }
}
