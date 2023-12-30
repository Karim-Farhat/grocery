import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {},
            child: Icon(color: Colors.black, Icons.arrow_back_ios_outlined),
          ),
          backgroundColor: Colors.white,
          title: Text(
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              'Cart'),
          centerTitle: true,
        ),
        body: Container(
          child: Stack(
            children: [
              SingleChildScrollView(
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
                          return Row(
                            children: [
                              Image.network(
                                  height: 100,
                                  'https://cdn.loveandlemons.com/wp-content/uploads/2020/01/oat-milk-778x1024.jpg'),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      'item name'),
                                  Text(
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      '\$20')
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                                child: Icon(color: Colors.white, Icons.remove),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  '5'),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                                child: Icon(color: Colors.white, Icons.add),
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, int i) {
                          return Divider();
                        },
                        itemCount: 5),
                    SizedBox(
                      height: 130,
                    )
                  ],
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
                      child: Text('Checkout')),
                ),
              )
            ],
          ),
        ));
  }
}
