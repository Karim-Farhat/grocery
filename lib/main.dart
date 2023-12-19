import 'package:flutter/material.dart';
import 'package:grocery2/pages/welcome1.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: WelcomePage(),
      );
}
