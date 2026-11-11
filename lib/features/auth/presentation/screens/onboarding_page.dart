import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('On Boarding Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers the buttons vertically
          children: [
            FilledButton(
              onPressed: () => context.go('/login'),
              child: const Text('Go to Login'),
            ),
            const SizedBox(height: 16), // Adds spacing between the buttons
            OutlinedButton(
              onPressed: () => context.go('/login'),
              child: const Text('Create an Account'),
            ),
          ],
        ),
      ),
    );
  }
}