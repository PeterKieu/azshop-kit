
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:azshop/providers/app_provider.dart';
import 'package:azshop/screens/splash.dart';
import 'package:azshop/util/const.dart';
import 'dart:async';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:azshop/util/app_settings.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  //1. load/check global parameters
  /// Obtain instance to streaming shared preferences, create MyAppSettings, and
  /// once that's done, run the app.
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await StreamingSharedPreferences.instance;
  final settings = MyAppSettings(preferences);
  Constants.settingMap['appsettings']=settings;

  //2.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()), //manage theme of app
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  final MyAppSettings settings = Constants.settingMap['appsettings'];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
          theme: appProvider.theme, //using stored shared preference
          home: SplashScreen(),
        );
      },
    );
  }
}