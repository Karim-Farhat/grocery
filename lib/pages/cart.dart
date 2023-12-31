import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List list = [];
  Map? map;
  int? quantity;
  String? email;
  int? Total_Cart;
  List<get_cart> cart_products = [];
  bool Trash = false;
  int? trash_id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(color: Colors.black, Icons.arrow_back_ios_outlined),
          ),
          backgroundColor: Colors.white,
          title: Text(
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              'Crt'),
          centerTitle: true,
        ),
        body: _widget());
  }

  Widget _widget() {
    if (false) {

    } else {
      return Container(
        child: Stack(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, int i) {
                          return GestureDetector(
                            onLongPress: () {
                              setState(() {
                                Trash = true;
                                trash_id = list[i]['id'];
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(
                                    height: 100, '${list[i]['image']}'),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        '${list[i]['product_name']}'),
                                    Text(
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        '\$${list[i]['price']}'),
                                    Text(
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                        'Total Price : \$${list[i]['total_price']} ')
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      delete(email!, cart_products[i].id!, 1);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                    child:
                                    Icon(color: Colors.white, Icons.remove),
                                  ),
                                ),
                                Text(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    '${list[i]['quantity']}'),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      increase(email!, cart_products[i].id!, 1);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                    child: Icon(color: Colors.white, Icons.add),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, int i) {
                          return Divider();
                        },
                        itemCount: list.length),
                    SizedBox(
                      height: 130,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                        ),
                        Text('Checkout '),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Color(0xFF489E67),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text('\$$Total_Cart')),
                      ],
                    )),
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    view_cart();
  }

  Future<void> view_cart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, dynamic>? decodedToken = Jwt.parseJwt(token ?? '');
    setState(() {
      email = decodedToken['email'];
    });
    http.Response response = await http
        .get(Uri.parse('http://35.209.150.159/cart-products?email=$email'));
    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> map = jsonDecode(response.body);
        Map map2 = map['data'];
        list = map2["products"];
        Total_Cart = map['total_price'];
        for (int i = 0; i < list.length; i++) {
          get_cart cart = get_cart.fromjson(list[i]);
          cart_products.add(cart);
        }
      });
    } else if (response.statusCode == 404) {
      setState(() {
        list.clear();
        map = jsonDecode(response.body);
      });
    }
  }

  Future<void> delete(String email, int product_id, int quantity) async {
    final Map<String, dynamic> delete_data = {
      'client_email': email,
      'product_id': product_id,
      'quan': quantity,
    };
    final http.Response response = await http.post(
      Uri.parse('http://35.209.150.159/removefromcart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(delete_data),
    );
    if (response.statusCode == 200) {
      setState(() {
        view_cart();
      });
    }
  }

  /*Future<void> decrease(String email, int product_id) async {
    final Map<String, dynamic> decrease_data = {
      'client_email': email,
      'product_id': product_id,
    };
    final http.Response response = await http.post(
      Uri.parse('http://34.31.110.154//decreaseProductQuantityInCart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(decrease_data),
    );
    if (response.statusCode == 200) {
      setState(() {
        view_cart();
      });
    }
  }*/

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
      setState(() {
        view_cart();
      });
    }
  }
}

class get_cart {
  String? name;
  String? image;
  int? price;
  int? quantity;
  int? id;
  int? calories;
  int? discount;
  String? brand;
  String? nationality;
  int? total;
  int? day;

  get_cart.fromjson(Map<String, dynamic> list) {
    name = list['productName'];
    image = list['productImage'];
    price = list['productPrice'];
    quantity = list['orderedQuantity'];
    id = list['id'];
    calories = list['calories'];
    discount = list['discount'];
    brand = list['brand'];
    nationality = list['nationality'];
    total = list['totalOrdersNumber'];
    day = list['lastDayOrders'];
  }
}
