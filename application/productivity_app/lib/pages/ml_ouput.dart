import 'package:flutter/material.dart';

class MLOutput extends StatefulWidget {
  const MLOutput({super.key});

  @override
  State<MLOutput> createState() => _MLOutputState();
}

class _MLOutputState extends State<MLOutput> {
  // Assuming you will add your TFLite model logic here
  String mlOutput = "Output from productivity_model.tflite";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: Colors.grey[900],
          child: Center(
            child: Text(
              mlOutput,
              style: TextStyle(fontSize: 20, color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}