import 'package:flutter/material.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

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
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Government',
                    //hintText: 'Address',
                  ),
                ),
              ),
              const SizedBox(height: 20.0), // For spacing
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Colors.green,
                      ),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Town',
                    //hintText: 'Address',
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Colors.green,
                      ),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    //hintText: 'Types of your area',
                  ),
                ),
              ),
              const SizedBox(
                  height: 10), // Use Spacer to push the button to the bottom
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
}
