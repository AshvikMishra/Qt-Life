import 'package:flutter/material.dart';

class MLOutput extends StatefulWidget {
  const MLOutput({super.key});

  @override
  State<MLOutput> createState() => _MLOutputState();
}

class _MLOutputState extends State<MLOutput> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Duration of the fade-in effect
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _controller.forward(); // Start the animation when the widget is built
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerSize = screenWidth - 40; // 20px padding on each side

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // 20px padding on all sides
          child: Stack(
            alignment: Alignment.topRight, // Align the button to the top right
            children: [
              Container(
                height: containerSize, // Make the height equal to width
                width: containerSize, // Set the width to the calculated size
                child: Card(
                  color: Colors.white,
                  elevation: 5, // Gives a slight shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0), // Inner padding for the card
                    child: Center(
                      child: FadeTransition(
                        opacity: _fadeAnimation, // Applies the fade-in animation
                        child: InteractiveViewer(
                          panEnabled: true, // Allows panning
                          scaleEnabled: true, // Allows zooming
                          minScale: 1.0,
                          maxScale: 4.0, // Adjust zoom limit
                          child: Image.asset(
                            'assets/predicted_productivity.png',
                            fit: BoxFit.contain, // Keeps the aspect ratio intact
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.grey[800]), // Adjust color if needed
                  onPressed: () {
                    Navigator.of(context).pushNamed('/landing');
                  },
                  tooltip: 'Back',
                  iconSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}