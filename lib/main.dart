import 'package:demoproject/profile.dart';
import 'package:flutter/material.dart';
import 'package:demoproject/dynamicUI.dart';
import 'package:demoproject/loginUI.dart';

// Define a global navigatorKey
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey, // Use the global navigatorKey
      home: LoginUI(),
      routes: {
        '/dynamicUI': (context) => DynamicUI(),
        '/loginUI': (context) => LoginUI(),
         '/profile': (context) => Profile(),
      },
    );
  }
}

