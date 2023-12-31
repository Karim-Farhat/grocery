import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery2/pages/signup.dart';
import 'package:grocery2/pages/test6.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grocery2/pages/home.dart';
import 'signup.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  bool _rememberMe = false;
  bool _isPasswordVisible =
      false; // Add a boolean variable to track the visibility state of the password
  var email;
  var password;
  var response;
  var image;
  bool isClosedeye = true;
  GlobalKey<FormState> KEY = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: color, width: 2.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // Background Image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/manwork.png',
                height: 500, // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
            // White container that contains text and buttons
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 450,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //const SizedBox(height: 1),
                      const Text(
                        'Sign in to your account',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                primary: Colors.green,
                              ),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          focusNode: _emailFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: const Icon(Icons.email),
                            focusedBorder: _border(Colors.green),
                            enabledBorder: _border(Colors.grey),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                primary: Colors.green,
                              ),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on _isPasswordVisible state, choose the icon
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                // Update the state to toggle password visibility
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            focusedBorder: _border(Colors.green),
                            enabledBorder: _border(Colors.grey),
                          ),
                          obscureText: !_isPasswordVisible,
                        ),
                      ),
                      const SizedBox(height: 5), // ... Rest of your widget tree
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Checkbox(
                                value: _rememberMe, // initial value
                                onChanged: (bool? value) {
                                  // handle check box state changes
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                                activeColor: Colors
                                    .green, // Set the active color to green
                                checkColor: Colors
                                    .white, // Set the check mark color to white
                              ),
                              const Text('Remember me'),
                            ],
                          ),
                          TextButton(
                            child: const Text(
                              'Forgot password',
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              // handle forgot password
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
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
                            setState(() {
                              login(email, password);
                            });
                          },
                          child: const Text('Login'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black, // Default text color
                              fontSize: 16.0, // Default font size
                            ),
                            children: <TextSpan>[
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Sign up',
                                style: const TextStyle(
                                  color: Colors.green, // Color for 'Login'
                                  decoration: TextDecoration
                                      .underline, // Underline 'Login'
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignupScreen()));
                                    // Your tap action for 'Login'
                                    //print('Login tapped');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login(String email, String password) async {
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password,
    };
    final http.Response response = await http.post(
      Uri.parse('http://35.209.150.159/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginData),
    );

    print('--------------------------------------------------------');
    print(response.statusCode);
    print('--------------------------------------------------------');
    print(response.body);

    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Navigator1();
        },
      ));
      Map<String, dynamic> map = json.decode(response.body);
      Map? map2 = map['data'];


      String token = map2!['token'] ?? '';

      if (true) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Navigator1();
          },
        ));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      }
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Wrong email or password')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('${response.statusCode}')));
    }
  }
}
