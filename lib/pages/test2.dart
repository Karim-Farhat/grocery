import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery Delivery',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const GroceryHomePage(),
    );
  }
}

class GroceryHomePage extends StatefulWidget {
  const GroceryHomePage({super.key});

  @override
  State<GroceryHomePage> createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/map.png'), // Replace with your asset image path
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(), // This will take all available space and push everything below it to the bottom
                  const Text(
                    'Get your groceries\ndelivered to your home',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Text(
                      'The best delivery app in town for delivering your daily fresh groceries',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement shop now action
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Text color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                    ),
                    child: const Text('Shop now'),
                  ),
                  const Spacer(), // Another Spacer to provide additional space at the bottom
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            // This is a placeholder for the groceries image at the bottom
            decoration: const BoxDecoration(
              color: Colors.white, // Placeholder color
              // Replace with your asset image if you have one
              // image: DecorationImage(
              //   image: AssetImage('assets/groceries.png'),
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
