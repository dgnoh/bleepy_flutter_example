import 'package:bleepy_flutter_example/screens/banner_screen.dart';
import 'package:bleepy_flutter_example/screens/bleepy_screen.dart';
import 'package:bleepy_flutter_example/screens/home_screen.dart';
import 'package:bleepy_flutter_example/screens/img_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bleepy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/banner') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return BannerScreen(url: args['url']);
            },
          );
        } else if (settings.name == '/imgpage') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return ImgScreen(userkey: args['userkey']);
            },
          );
        } else if (settings.name == '/home') {
          return MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          );
        } else if (settings.name == '/bleepy') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return BleepyLauncherScreen(launcherUrl: args['launcherUrl']);
            },
          );
        }
        return null;
      },
    );
  }
}
