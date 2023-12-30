import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FindProductsPage extends StatefulWidget {
  const FindProductsPage({super.key});

  @override
  State<FindProductsPage> createState() => _FindProductsPageState();
}

class _FindProductsPageState extends State<FindProductsPage> {
  List list = [];
  List images = [];
  List<allproduct> products = [];

  void _openFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const FiltersPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Find Products'),
          actions: [
            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () => _openFilters(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                //height: 10,
                //width: 50,
                child: Padding(
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
              ),
              SizedBox(
                //height: 50,
                //width: 50,
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, int i) {
                      int index = 2 * i;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 200,
                              width: 150, // Adjust width as needed
                              padding: const EdgeInsets.all(10),

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
                                children: <Widget>[
                                  Image.network(
                                    '${products[index].image}', // Use the passed imagePath
                                    fit: BoxFit
                                        .contain, // Use BoxFit.contain to keep the image aspect ratio
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'title', // Use the passed title
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'subtitle', // Use the passed subtitle
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      //onTap: onAddTap, // Use the passed callback for the add tap
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                            ),
                          ),
                          const SizedBox(
                            width: 55,
                          ),
                          list.length % 2 != 0 && i == list.length - 1
                              ? SizedBox.shrink()
                              : GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 200,
                                    width: 150, // Adjust width as needed
                                    padding: const EdgeInsets.all(10),

                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          58, 185, 185, 185),
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
                                      children: <Widget>[
                                        Image.network(
                                          '${products[index + 1].image}',

                                          fit: BoxFit
                                              .contain, // Use BoxFit.contain to keep the image aspect ratio
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'title', // Use the passed title
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          'subtitle', // Use the passed subtitle
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        const SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            //onTap: onAddTap, // Use the passed callback for the add tap
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(50),
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
                                  ),
                                )
                        ],
                      );
                    },
                    separatorBuilder: (context, int i) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: products.length),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    get_products();
  }

  Future<void> get_products() async {
    http.Response response =
        await http.get(Uri.parse('http://35.209.150.159/getallproducts'));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      print(response.body);
      list = map['data'];
      print(list);
      setState(() {
        for (int i = 0; i < list.length; i++) {
          allproduct Allproduct = allproduct.fromjson(list[i]);
          products.add(Allproduct);
        }
      });
    }
  }
}

class allproduct {
  String? name;
  String? brand;
  double? price;
  String? image;

  allproduct.fromjson(Map<String, dynamic> list) {
    name = list['productName'];
    brand = list['brand'];
    price = list['productPrice'];
    image = list['productImage'];
  }
}

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  final Map<String, bool?> _filters = {
    'Eggs': false,
    'Noodles & Pasta': false,
    'Chips & Crisps': false,
    'Fast Food': false,
  };

  void _applyFilters() {
    Navigator.pop(context);
    // Apply your filters
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          AppBar(
            title: const Text('Filters'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: _filters.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: _filters[key] ??
                      false, // Handle null by providing a default value
                  onChanged: (bool? value) {
                    // Accept a nullable bool
                    setState(() {
                      _filters[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: _applyFilters,
            child: const Text('Apply Filters'),
          )
        ],
      ),
    );
  }
}
