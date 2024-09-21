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

  @override
  void initState() {
    super.initState();
    _animateCards();
  }

  Future<void> _animateCards() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _firstCardOpacity = 1.0; // Fade in first card
    });

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _secondCardOpacity = 1.0; // Fade in second card
    });

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _thirdCardOpacity = 1.0; // Fade in third card
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
        
            return Column(
              children: [
                // First card - 20% of the screen
                AnimatedOpacity(
                  opacity: _firstCardOpacity,
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    height: height * 0.2,
                    width: double.infinity,
                    child: Card(
                      color: Colors.grey[900],
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
                // Second card - 50% of the screen
                AnimatedOpacity(
                  opacity: _secondCardOpacity,
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    height: height * 0.5,
                    width: double.infinity,
                    child: Card(
                      color: Colors.grey[800],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 30, 5, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome to our Project!',
                                style: TextStyle(fontSize: 22, color: Colors.yellow[200]),
                              ),
                              Divider(height: 10, color: Colors.grey[200],),
                              const Text(
                                "We're making a dynamic scheduling app based on machine learning that uses a reinforced learning pattern to understand the user's productive hours and suggest a schedule. Over time it would predict your naturally productive hours and help you schedule your time more effectively.",
                                style: TextStyle(fontSize: 18, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Third card (Button) - 30% of the screen
                AnimatedOpacity(
                  opacity: _thirdCardOpacity,
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    height: height * 0.3,
                    width: double.infinity,
                    child: Card(
                      color: Colors.grey[900],
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/productivity_app'); // Navigate to the productivity app screen
                        },
                        icon: Icon(Icons.touch_app, size: 40, color: Colors.amber[200]),
                        label: Text(
                          'Get Started',
                          style: TextStyle(color: Colors.amber[200], fontSize: 24),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Make the button fill the card
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}