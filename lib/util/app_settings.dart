import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';


/// A class that holds [Preference] objects for the common values that you want
/// to store in your app. This is *not* necessarily needed, but it makes your
/// code more neat.
///
/// (In a real app you'd want to use an [InheritedWidget] to pass this around).
class MyAppSettings {
  //contructor
  MyAppSettings(StreamingSharedPreferences preferences)
      : skipWalkthrough = preferences.getBool('WalkthroughState', defaultValue: true),
        darkMode = preferences.getBool('darkMode', defaultValue: false),
        theme = preferences.getString('theme', defaultValue: 'light');

  final Preference<bool> skipWalkthrough;
  final Preference<bool> darkMode;
  final Preference<String> theme;

  //getter/setter by skipWalkthrough.getValue()/skipWalkthrough.setValue(true)
  //then automatically synchronize with: preferences.setBool('WalkthroughState', true),

}