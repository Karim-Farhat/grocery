import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ShoppingCartPage(),
    );
  }
}

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: <Widget>[
          // A placeholder list of items in the cart
          Expanded(
            child: ListView.builder(
              itemCount: 4, // The number of items in the cart
              itemBuilder: (context, index) {
                // Replace with your custom list item widget
                return ListTile(
                  title: Text('Item $index'),
                  subtitle: const Text('Quantity: 1'),
                  trailing: const Text('\$2.99'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckoutPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // set the background color
            ),
            child: const Text('Go to Checkout'),
          ),
        ],
      ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: <Widget>[
          // Your checkout fields here
          ListTile(
            title: const Text('Delivery'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              // Open delivery options
            },
          ),
          ListTile(
            title: const Text('Payment'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              // Open payment options
            },
          ),
          ListTile(
            title: const Text('Promo Code'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              // Open promo code input
            },
          ),
          const ListTile(
            title: Text('Total Cost'),
            trailing: Text('\$12.96'),
          ),
          ElevatedButton(
            onPressed: () {
              // Submit the order
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // set the background color
            ),
            child: const Text('Place Order'),
          ),
        ],
      ),
    );
  }
}
