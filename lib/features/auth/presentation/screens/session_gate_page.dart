import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/session_provider.dart';

class SessionGatePage extends ConsumerWidget {
  const SessionGatePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserEntity?> session = ref.watch(sessionProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: session.hasError
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Could not restore your session.'),
                    TextButton(
                      onPressed: () => ref.invalidate(sessionProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
