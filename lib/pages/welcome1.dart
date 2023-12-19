import 'package:flutter/material.dart';
import 'package:grocery2/pages/welcome2.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context)
            .size
            .width, // Ensures the container fills the width.
        height: MediaQuery.of(context)
            .size
            .height, // Ensures the container fills the height.
        decoration: const BoxDecoration(
          // Add your background image here
          image: DecorationImage(
            image: AssetImage(
                "assets/images/grocery_man.png"), // replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(flex: 20),

            // Add your top text here

            // Add your grocery basket image here
            Image.asset(
              'assets/images/logo.png', // replace with your basket image path
              height: 80, // set this to the size of your image
            ),
            Align(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  //style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Welcome to Eat',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    TextSpan(
                        text: 'M',
                        style: TextStyle(color: Colors.green, fontSize: 40)),
                    TextSpan(
                        text: 'e',
                        style: TextStyle(color: Colors.white, fontSize: 40)),
                  ],
                ),
              ),
            ),
            const Text(
              'Get your groceries in as fast as one hour',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            // Add your button here
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()));
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // background color
                    foregroundColor: Colors.white, // text color // Button size
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fixedSize: const Size(250, 50)),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
