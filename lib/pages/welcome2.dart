import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery2/pages/login.dart';
import 'package:grocery2/pages/signup.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              'assets/images/youngmanwithabasket.png',
              height: 500, // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // White container that contains text and buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // height: MediaQuery.of(context).size.height  2, // Half the height of the screen
              height: 350,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), // Adjust the radius as needed
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                    24.0), // Add padding inside the container
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
                    const SizedBox(height: 5), // Spacing between text
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                        height:
                            25), // Use a Spacer to fill the space between text and buttons
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final GoogleSignInAccount? account =
                              await _googleSignIn.signIn();
                          if (account != null) {
                            // User signed in with Google. You can access account.email to get the selected email.
                            print('Selected email: ${account.email}');
                          } else {
                            // User canceled the sign-in process.
                            print('Sign-in canceled');
                          }
                        } catch (error) {
                          // Handle sign-in errors.
                          print('Error during sign-in: $error');
                        }
                        // Handle Google sign-in logic
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        backgroundColor: const Color.fromARGB(
                            255, 0, 0, 0), // Set the text color to black
                        minimumSize: const Size(double.infinity,
                            50), // Set the button to take the full width
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10), // Add padding to the button
                        alignment: Alignment.centerLeft,
                      ),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/googlelogo.png', // Replace with your logo asset path
                              height:
                                  30.0, // Adjust the size of the logo as needed
                            ),
                            const SizedBox(width: 75.0),
                            const Text('Continue with Google'),
                          ]),
                    ),
                    const SizedBox(height: 20), // Spacing between buttons
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const SignupScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(
                            255, 26, 168, 40), // Text color
                        minimumSize:
                            const Size(double.infinity, 50), // Button size
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10), // Add padding to the button
                        alignment:
                            Alignment.centerLeft, // Align content to the left
                      ),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/manlogo.png', // Replace with your logo asset path
                              height:
                                  30.0, // Adjust the size of the logo as needed
                            ),
                            const SizedBox(width: 75.0),
                            const Text('Create an account'),
                          ]),
                    ),
                    const SizedBox(height: 25), // Spacing after the last button
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black, // Default text color
                            fontSize: 16.0, // Default font size
                          ),
                          children: <TextSpan>[
                            const TextSpan(text: 'Already have an account? '),
                            TextSpan(
                              text: 'Login',
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
                                              const LoginScreen()));
                                  // Your tap action for 'Login'
                                  //print('Login tapped');
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(), // Use another Spacer here if needed
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
