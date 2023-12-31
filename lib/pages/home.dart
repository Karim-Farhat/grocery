import 'package:flutter/material.dart';
import 'package:grocery2/pages/brand.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery App UI',
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int _selectedIndex = 1; // Default index of first screen

  /* void _onItemTapped(int index) {
    setState(() {
    _selectedIndex = index;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Welcome Karim",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: const <Widget>[
          //Padding(
          //padding: EdgeInsets.only(right: 16.0),
          //child: Icon(Icons.notifications_none, color: Colors.black),
          //),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Brand',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Container(
              width: 350,
              padding: const EdgeInsets.all(31),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 28, 170, 61),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: IntrinsicHeight(
                // This will ensure the children of Row respect the height of the tallest child
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Offer",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          Text(
                            'Up to 25%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // You need to provide a width for the image since it's inside a Row with no bounded width
                    SizedBox(
                      width: 120, // Adjust the width as necessary
                      child: Image.asset(
                        'assets/images/meat.png', // Replace with your image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                    /*   ElevatedButton(
                      onPressed: () {
                        // Handle grab offer logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: const Text(
                        'Grab Offer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Brands 🏬",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("See all"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildCategoryItem(
                      'Marai', 'assets/images/marai.png', () {}),
                  _buildCategoryItem('Pepsi', 'assets/images/meat.png',
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BrandPage()));
                  }),
                  _buildCategoryItem('Juhaina', 'assets/images/meat.png', () {}),
                  _buildCategoryItem('Fayrouz', 'assets/images/meat.png', () {}),
                  _buildCategoryItem('Friends', 'assets/images/meat.png', () {}),
                  _buildCategoryItem('Carrier', 'assets/images/meat.png', () {}),
                  // Add more categories here
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Best Selling 🔥",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("See all"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 254.5,
              width: 350,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildProductItem(
                    context,
                    'Meat',
                    '1kg, £ 3.75',
                    'assets/images/meat.png',
                    () {
                      // Handle the add tap here
                    },
                  ),
                  _buildProductItem(
                    context,
                    'Meat',
                    '1kg, £ 3.75',
                    'assets/images/meat.png',
                    () {
                      // Handle the add tap here
                    },
                  ),
                  _buildProductItem(
                    context,
                    'Meat',
                    '1kg, £ 3.75',
                    'assets/images/meat.png',
                    () {
                      // Handle the add tap here
                    },
                  ),

                  // Add more categories here
                ],
              ),
            ),

            // Add your best selling products ListView here
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(
                    8.0), // Padding for the image inside the circle
                child: Image.asset(imagePath,
                    fit: BoxFit.cover), // Use your own image asset
              ),
            ),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }

// ignore: unused_element
  Widget _buildProductItem(
    BuildContext context,
    String title,
    String subtitle,
    String imagePath,
    VoidCallback onAddTap,
  ) {
    return Container(
      width: 160, // Adjust width as needed
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(58, 185, 185, 185),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Center(
              // Center the image within the Expanded widget
              child: Image.asset(
                imagePath, // Use the passed imagePath
                fit: BoxFit
                    .contain, // Use BoxFit.contain to keep the image aspect ratio
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title, // Use the passed title
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle, // Use the passed subtitle
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: onAddTap, // Use the passed callback for the add tap
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
  }

  @override
  void initstate() {
    get_products();
  }

  Future<void> get_products() async {
    http.Response response =
        await http.get(Uri.parse('http://35.209.150.159/getallproducts'));
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      print(response.body);
      List list = map['data'];
      print(list);
      setState(() {
        for (int i = 0; i < list.length; i++) {
          List images = list[i]['productImage'];
        }
      });
    }
  }
}
