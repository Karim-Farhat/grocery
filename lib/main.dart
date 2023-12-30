import 'package:flutter/material.dart';
import 'package:grocery2/pages/test6.dart'; // Make sure to import your Dashboard
import 'package:grocery2/pages/welcome1.dart'; // Make sure to import your Dashboard

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // Define named routes
      routes: {
        '/': (context) => const WelcomePage(),
        '/dashboard': (context) => const Navigator1(),
      },
      initialRoute: '/', // Start with the WelcomePage
    );
  }
}
