import 'package:grocery2/pages/test4.dart';
import 'package:grocery2/pages/test5.dart';
import 'package:grocery2/pages/test7.dart';
import 'package:flutter/material.dart';
import 'package:grocery2/pages/home.dart';
import 'cart.dart';

class Navigator1 extends StatefulWidget {
  const Navigator1({Key? key}) : super(key: key);

  @override
  State<Navigator1> createState() => _Navigator1State();
}

class _Navigator1State extends State<Navigator1> {
  int _selectedIndex = 0; // Default index of first screen

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _tabs = [
    const HomePage(),
    FindProductsPage(),
    const AccountPage(),
    const CartScreen(),
    // Add more pages as necessary
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0 ? Colors.black : Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: _selectedIndex == 1 ? Colors.black : Colors.grey),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 2 ? Colors.black : Colors.grey),
            label: 'Profile',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
                color: Colors.green), // This icon will always be green
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
      ),
    );
  }
}
