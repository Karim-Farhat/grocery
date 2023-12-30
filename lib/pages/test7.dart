import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AccountPage(),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
                'https://via.placeholder.com/150'), // Replace with your network image or asset.
          ),
          const Text(
            'karim',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Orders'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to orders page
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('My Details'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to details page
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Delivery Address'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to delivery address page
            },
          ),
          // ... Add other ListTiles for each menu item
          ElevatedButton(
            onPressed: () {
              // Log out logic
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green, // foreground
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
