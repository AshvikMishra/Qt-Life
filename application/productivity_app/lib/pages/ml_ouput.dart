import 'package:flutter/material.dart';

class MLOutput extends StatefulWidget {
  const MLOutput({super.key});

  @override
  State<MLOutput> createState() => _MLOutputState();
}

class _MLOutputState extends State<MLOutput> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        "Machine Learning Output page"
      ),
    );
  }
}