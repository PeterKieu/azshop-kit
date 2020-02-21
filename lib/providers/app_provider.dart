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
    if(c == "dark" ){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor:  Constants.darkPrimary ,
        statusBarIconBrightness:  Brightness.light,
      ));
    }else{
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Constants.lightPrimary,
        statusBarIconBrightness: Brightness.dark,
      ));
    }

    notifyListeners();
    this.settings.theme.setValue(c);
  }

  ThemeData getTheme(value) {
    String c = this.settings.theme.getValue();
    theme = c == "dark"? Constants.darkTheme:Constants.lightTheme;
    return theme;
  }


  void checkTheme(MyAppSettings settings) {
    String r = settings.theme.getValue();
    if(r == "light"){
      setTheme(Constants.lightTheme, "light");
    }else{
      setTheme(Constants.darkTheme, "dark");
    }

  }
}