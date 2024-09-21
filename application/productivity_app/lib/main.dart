import 'package:flutter/material.dart';
import 'package:productivity_app/pages/productivity_app.dart';
import 'package:productivity_app/pages/landing.dart';
import 'package:productivity_app/pages/about.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/productivity_app",
    routes: {
      "/": (context) => const Landing(),
      "/about": (context) => const About(),
      "/productivity_app": (context) => const ProductivityApp(),
    },
  ));
}
