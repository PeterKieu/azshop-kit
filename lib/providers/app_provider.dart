import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:azshop/util/const.dart';

import 'package:azshop/util/app_settings.dart';

class AppProvider extends ChangeNotifier{
  //constructor checks theme settings in preference and use it

  AppProvider(){
    checkTheme(this.settings);
  }
  final MyAppSettings settings = Constants.settingMap['appsettings'];

  //default them on every time app init,
  //=> we can save and load on startup or
  //=> we can check and use the system theme
  ThemeData theme = Constants.lightTheme;

  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }

  //this routine save data in Shared preference, and only lost when uninstalling app
  //and set all UI items into target theme
  void setTheme(value, c) {
    theme = value;

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: c == "dark" ? Constants.darkPrimary : Constants.lightPrimary,
      statusBarIconBrightness: c == "dark" ? Brightness.light:Brightness.dark,
    ));

    notifyListeners();
  }

  ThemeData getTheme(value) {
    return theme;
  }


  void checkTheme(MyAppSettings settings) {

    String r = settings.theme.getValue();

    if(r == "light"){
//      t = Constants.lightTheme;
      setTheme(Constants.lightTheme, "light");
    }else{
//      t = Constants.darkTheme;
      setTheme(Constants.darkTheme, "dark");
    }


  }
}