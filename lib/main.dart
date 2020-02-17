import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:azshop/providers/app_provider.dart';
import 'package:azshop/screens/splash.dart';
import 'package:azshop/util/const.dart';


void main() {
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
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
          theme: appProvider.theme,
          home: SplashScreen(),
        );
      },
    );
  }
}