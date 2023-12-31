import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery2/pages/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:grocery2/pages/login.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FocusNode? _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  bool _rememberMe = false;
  bool _isPasswordVisible =
      false; // Add a boolean variable to track the visibility state of the password
  final _phoneNumberController = TextEditingController();
  final _phoneNumberFocusNode = FocusNode();
  String? _phoneNumberErrorText;

  GlobalKey<FormState> KEY = GlobalKey<FormState>();
  var email;
  var name;
  var password;
  var phoneNumber;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: color, width: 2.0),
    );
  }

  bool _isPhoneNumberValid(String? number) {
    final validPrefixes = ['015', '012', '011', '010'];
    return number != null &&
        number.length == 11 &&
        validPrefixes.any((prefix) => number.startsWith(prefix));
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
                'assets/images/womanbuy.png',
                height: 500, // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
            // White container that contains text and buttons
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 600,
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
                      const SizedBox(height: 15),
                      Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                primary: Colors.green,
                              ),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          focusNode: _nameFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon:
                                const Icon(Icons.account_circle_outlined),
                            focusedBorder: _border(Colors.green),
                            enabledBorder: _border(Colors.grey),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                primary: Colors.green,
                              ),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
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
                      const SizedBox(height: 15),
                      Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                primary: Colors.green,
                              ),
                        ),
                        child: TextFormField(
                          controller: _phoneNumberController,
                          focusNode: _phoneNumberFocusNode,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: const Icon(Icons.phone),
                            errorText: _phoneNumberErrorText,
                            focusedBorder: _border(Colors.green),
                            enabledBorder: _border(Colors.grey),
                          ),
                          onChanged: (value) {
                            if (!_isPhoneNumberValid(value)) {
                              setState(() {
                                _phoneNumberErrorText =
                                    'Enter a valid phone number (e.g., 01234567890)';
                              });
                            } else {
                              setState(() {
                                _phoneNumberErrorText = null;
                                phoneNumber = value;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
                      const SizedBox(height: 0), // ... Rest of your widget tree
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
                        height: 5,
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
                            if (true) {
                              createNewAccount(
                                email,
                                password,
                                name,
                                phoneNumber,
                              );
                            }
                          },
                          child: const Text('Sign up'),
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
                              const TextSpan(
                                  text: "Already have an account ? "),
                              TextSpan(
                                text: 'Log in',
                                style: const TextStyle(
                                  color: Colors.green, // Color for 'Login'
                                  decoration: TextDecoration
                                      .underline, // Underline 'Login'
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
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

  Future<void> createNewAccount(
      String email, String password, String name, String number) async {
    final Map<String, dynamic> signup_data = {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
    final http.Response response = await http.post(
        Uri.parse('http://35.209.150.159/signup'),
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
          backgroundColor: Colors.red, content: Text('Connection Error')));
      print(response.statusCode);
    }
  }
}
