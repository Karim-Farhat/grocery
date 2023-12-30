import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vegetables',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const BrandPage(),
    );
  }
}

class BrandPage extends StatefulWidget {
  const BrandPage({super.key});

  @override
  State<BrandPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BrandPage> {
  final List<Map<String, dynamic>> products = [
    {'name': 'meat', 'weight': '1Kg', 'price': 5},
    {'name': 'meat', 'weight': '1Kg', 'price': 5},
    {'name': 'meat', 'weight': '1Kg', 'price': 5},
    {'name': 'meat', 'weight': '1Kg', 'price': 5},
    {'name': 'meat', 'weight': '1Kg', 'price': 5},
    {'name': 'meat', 'weight': '1Kg', 'price': 5},
    {'name': 'meat', 'weight': '1Kg', 'price': 5},
    {'name': 'meat', 'weight': '1Kg', 'price': 5},
    {'name': 'meat', 'weight': '1Kg', 'price': 5},
    {'name': 'marai', 'weight': '1Kg', 'price': 5},
    // ... Add other products here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vegetables'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.8,
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/${products[index]['name']}.png'),
                Text(products[index]['name']),
                Text(
                    '${products[index]['weight']}, ${products[index]['price']}'),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      // Handle button press
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add cart functionality
        },
        child: const Icon(Icons.shopping_cart),
      ),*/
      /* bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          // Add other navigation items here
        ],
      ),*/
    );
  }
}
