import 'package:flutter/material.dart';
import 'package:grocery2/pages/test6.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:grocery2/pages/login.dart';

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
      title: 'Grocery Delivery',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LocationPage(),
    );
  }
}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GlobalKey<FormState> KEY = GlobalKey<FormState>();
  var email;
  var date;
  var address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Location'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0), // For spacing
              Image.asset(
                'assets/images/map.png', // Replace with your location image asset path
                height: 200.0, // Set an appropriate height
              ),
              const SizedBox(height: 40.0), // For spacing
              const Text(
                'Select Your Location',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0), // For spacing
              const Text(
                'Switch on your location to stay in tune with what’s happening in your area',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0), // For spacing
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Colors.green,
                      ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    //hintText: 'Address',
                  ),
                  onChanged: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20.0), // For spacing
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Colors.green,
                      ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Birth of date',
                    //hintText: 'fdmvdfv',
                  ),
                  onChanged: (value) {
                    date = value.toString();
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Colors.green,
                      ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Confirm your mail',
                    //hintText: 'Types of your area',
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                  height: 100), // Use Spacer to push the button to the bottom
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // background color
                      foregroundColor:
                          Colors.white, // text color // Button size
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      fixedSize: const Size(300,
                          50) // double.infinity is the width and 50 is the height
                      ),
                  onPressed: () {
                    if (true) {
                      takeAddress(email, date, address);
                    }
                    // handle login logic
                  },
                  child: const Text('Submit'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> takeAddress(String email, String date, String address) async {
    final Map<String, dynamic> signup_data = {
      'email': email,
      'birthDate': date,
      'address': address,
    };
    final http.Response response = await http.post(
        Uri.parse('http://35.209.150.159/complete-signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(signup_data));
    Map<String, dynamic> map = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, content: Text('Account Created')));
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text('${response.statusCode}')));
      print(response.statusCode);
    }
  }
}
