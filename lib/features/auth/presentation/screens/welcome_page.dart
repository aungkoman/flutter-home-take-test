import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDEEF4), // Light pink background matching reference
      body: Stack(
        children: [
          // Background layout with donuts (placeholders used here as we don't have the assets)
          // In a real app, you would use Image.asset with the actual donut images
          Positioned(
            top: -20,
            left: -20,
            child: _buildPlaceholderDonut(const Color(0xFFB3E5FC), Colors.deepPurpleAccent), // Top left donut
          ),
          Positioned(
            top: 40,
            right: -40,
            child: _buildPlaceholderDonut(const Color(0xFFFFCDD2), Colors.pink[300]!), // Top right donut
          ),
          Positioned(
            top: 250,
            left: -30,
            child: _buildPlaceholderDonut(const Color(0xFFF8BBD0), Colors.pinkAccent), // Bottom left donut
          ),
          Positioned(
            top: 350,
            right: -20,
            child: _buildPlaceholderDonut(const Color(0xFFFFCC80), Colors.brown), // Bottom right donut
          ),

          // Gradient overlay for bottom section text
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    const Color(0xFFFDEEF4).withOpacity(0.8),
                    const Color(0xFFFDEEF4),
                  ],
                  stops: const [0.5, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // Content overlay
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                const Text(
                  'Welcome to the\nworld of J\'donuts',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 32.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => context.go('/home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4FC3F7), // Light blue button
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'LET\'S EXPLORE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create placeholder colored squares for the donuts
  Widget _buildPlaceholderDonut(Color bgColor, Color donutColor) {
    return Container(
      width: 220,
      height: 280,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: Center(
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
              color: donutColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white30, width: 20)
          ),
        ),
      ),
    );
  }
}