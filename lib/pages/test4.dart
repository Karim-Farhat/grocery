import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class FindProductsPage extends StatefulWidget {
  const FindProductsPage({super.key});

  @override
  State<FindProductsPage> createState() => _FindProductsPageState();
}

class _FindProductsPageState extends State<FindProductsPage> {
  List list = [];
  List images = [];
  List<allproduct> products = [];
  bool issearch = false;
  bool getall = true;
  List search_products = [];
  String? search_name;
  String? email;

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
                    onSubmitted: (value) {
                      setState(() {
                        search_name = value;
                        get_search(search_name!);
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        issearch = true;
                        getall = false;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
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
                  child: _widget()),
            ],
          ),
        ));
  }

  Widget _widget() {
    if (getall == true) {
      return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, int i) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 370,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.only(top: 3, right: 3, left: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              height: 200,
                              width: 370,
                              '${products[i].image}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              '${products[i].name}'),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              "${products[i].brand}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                  "\$${products[i].price}"),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    increase(email!, products[i].id!, 1);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green),
                                  child: Icon(
                                      color: Colors.white,
                                      Icons.add_shopping_cart_rounded),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: products.length);
    } else if (issearch == true) {
      return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, int i) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 370,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.only(top: 3, right: 3, left: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              height: 200,
                              width: 370,
                              '${search_products[i]['productImage']}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              '${search_products[i]['productName']}'),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              "${search_products[i]['brand']}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                  "\$${search_products[i]['productPrice']}"),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    //  get_products(email!, products[i].id!);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green),
                                  child: Icon(
                                      color: Colors.white,
                                      Icons.add_shopping_cart_rounded),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: search_products.length);
    } else {
      return SizedBox();
    }
  }

  @override
  void initState() {
    get_products();
    getdata();
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

  Future<void> get_search(String name) async {
    http.Response response = await http
        .get(Uri.parse('http://35.209.150.159/getbysearch?keyword=$name'));
    if (response.statusCode == 200) {
      print(list);
      setState(() {
        Map<String, dynamic> map = jsonDecode(response.body);

        search_products = map['data'];
      });
    }
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, dynamic>? decodedToken = Jwt.parseJwt(token ?? '');
    setState(() {
      email = decodedToken['email'];
      print(email);
    });
  }

  Future<void> increase(String email, int product_id, int quantity) async {
    final Map<String, dynamic> increase_data = {
      'client_email': email,
      'product_id': product_id,
      'quan': quantity
    };
    final http.Response response = await http.post(
      Uri.parse('http://35.209.150.159/addtocart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(increase_data),
    );
    if (response.statusCode == 200) {
      setState(() {});
    }
  }
}

class allproduct {
  String? name;
  String? brand;
  double? price;
  String? image;
  int? id;

  allproduct.fromjson(Map<String, dynamic> list) {
    name = list['productName'];
    brand = list['brand'];
    price = list['productPrice'];
    image = list['productImage'];
    id = list['id'];
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
