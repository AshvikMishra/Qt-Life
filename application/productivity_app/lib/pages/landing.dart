import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:productivity_app/pages/productivity_app.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landing Page',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[850],
      ),
      home: const LandingPage(),
      routes: {
        '/productivity_app': (context) => const ProductivityApp(), // Define your productivity app screen here
      },
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double _firstCardOpacity = 0.0;
  double _secondCardOpacity = 0.0;
  double _thirdCardOpacity = 0.0;
  double _fourthCardOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _animateCards();
  }

  Future<void> _animateCards() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _firstCardOpacity = 1.0;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _secondCardOpacity = 1.0;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _thirdCardOpacity = 1.0;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _fourthCardOpacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First card: Clock icon and "Qt-Life" text
                AnimatedOpacity(
                  opacity: _firstCardOpacity,
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0), // 10px space between cards
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.grey[900],
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time, size: 80, color: Colors.amber[200]), // Clock icon
                            const SizedBox(height: 10),
                            Text(
                              'Qt-Life',
                              style: TextStyle(fontSize: 36, color: Colors.amber[200], fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Second card: Fading text (constant card size)
                AnimatedOpacity(
                  opacity: _secondCardOpacity,
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0), // 10px space between cards
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.grey[900],
                      child: Container(
                        height: 150, // Constant height for the second card
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        width: double.infinity,
                        child: Center(
                          child: AnimatedTextKit(
                            animatedTexts: [
                              FadeAnimatedText('AI-powered Scheduling', textStyle: TextStyle(fontSize: 30, color: Colors.amber[200]), duration: const Duration(milliseconds: 2000)),
                              FadeAnimatedText('Tailored to You', textStyle: TextStyle(fontSize: 30, color: Colors.amber[200]), duration: const Duration(milliseconds: 2000)),
                              FadeAnimatedText('Get Organized!', textStyle: TextStyle(fontSize: 30, color: Colors.amber[200]), duration: const Duration(milliseconds: 2000)),
                            ],
                            repeatForever: true,
                            pause: const Duration(milliseconds: 1000),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Third card: Description text
                AnimatedOpacity(
                  opacity: _thirdCardOpacity,
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0), // 10px space between cards
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.grey[800],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
                          children: [
                            Text(
                              'Welcome to our Project!',
                              style: TextStyle(fontSize: 22, color: Colors.yellow[200]),
                              textAlign: TextAlign.center, // Center the text within the widget
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            const Text(
                              "We're building a dynamic scheduling app that uses machine learning to optimize your productive hours and suggest a tailored schedule.",
                              style: TextStyle(fontSize: 18, color: Colors.white70),
                              textAlign: TextAlign.center, // Center the text within the widget
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Fourth card: Get Started button (same width as the other cards)
                AnimatedOpacity(
                  opacity: _fourthCardOpacity,
                  duration: const Duration(milliseconds: 1000),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: Colors.grey[900],
                    child: Container(
                      width: double.infinity, // Make the card full-width like the others
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/productivity_app');
                          },
                          icon: Icon(Icons.check, size: 30, color: Colors.amber[200]),
                          label: Text(
                            'Get Started',
                            style: TextStyle(color: Colors.amber[200], fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                          ),
                        ),
                      ),
                    ),
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
