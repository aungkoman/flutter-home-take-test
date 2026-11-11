import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Center(
        child: FilledButton(
          onPressed: () => context.go('/home'),
          child: const Text('Go to Home'),
        ),
      ),
    );
  }
}
