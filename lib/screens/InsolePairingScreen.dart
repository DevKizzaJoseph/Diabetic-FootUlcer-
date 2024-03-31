import 'package:flutter/material.dart';

class InsolePairingScreen extends StatelessWidget {
  const InsolePairingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Connect Your Insoles',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.blue), // Made the text bold and colored to stand out
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Step 1: Turn On Your Insoles',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87), // Increased font size and weight for clarity
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Press and hold the button for 3 seconds until the light turns blue.',
              style: TextStyle(fontSize: 16.0, color: Colors.black54), // Slightly dimmed the color for less important text
              textAlign: TextAlign.center, // Centered text for better aesthetics
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              'assets/smart_insole.png',// Ensure your image path is correct
              height: 250.0, // Adjusted the image size for better visibility
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Step 2: Pair with Your Phone',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87), // Consistent styling with step 1
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Open your phone\'s Bluetooth settings.',
              style: TextStyle(fontSize: 16.0, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Placeholder for your pairing logic
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Button padding
              ),
              child: const Text('Start Pairing', style: TextStyle(fontSize: 18.0)),
            ),
          ],
        ),
      ),
    );
  }
}