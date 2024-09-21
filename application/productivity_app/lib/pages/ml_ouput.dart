import 'package:flutter/material.dart';

class MLOutput extends StatefulWidget {
  const MLOutput({super.key});

  @override
  State<MLOutput> createState() => _MLOutputState();
}

class _MLOutputState extends State<MLOutput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0), // 20px padding on all sides
        child: Card(
          elevation: 5, // Gives a slight shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0), // Inner padding for the card
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/predicted_productivity.png',
                    fit: BoxFit.cover, // Ensures the image fills the card
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}