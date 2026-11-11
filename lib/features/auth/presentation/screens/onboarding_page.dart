import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5), // Soft pink background
      body: Stack(
        children: [
          // Background Assets Placeholder
          // Replace these Containers with Positioned Image.asset() for the donuts
          Positioned(
            top: -40,
            left: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // ... add other donut images using Positioned ...

          // Foreground Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Round food for\nevery mood',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E212B),
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Primary Action Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/login');
                      }, // No business logic
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5AD4EE),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'LET\'S GET STARTED',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Secondary Login Text
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(
                            color: Color(0xFFE94E8C), // Pink highlight
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Social Icons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(Icons.g_mobiledata, Colors.red),
                    const SizedBox(width: 24),
                    _buildSocialIcon(Icons.apple, Colors.black),
                    const SizedBox(width: 24),
                    _buildSocialIcon(Icons.facebook, Colors.blue.shade700),
                  ],
                ),
                const SizedBox(height: 32),

                // Footer Terms
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'By continuing, you acknowledge that you have read and\nagree to our ',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 12,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Use',
                          style: TextStyle(color: Color(0xFFE94E8C)),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy.',
                          style: TextStyle(color: Color(0xFFE94E8C)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to generate consistent social icons
  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 28),
        onPressed: () {}, // No business logic
      ),
    );
  }
}