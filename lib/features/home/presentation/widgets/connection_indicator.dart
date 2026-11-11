import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final internetStatusProvider = StreamProvider.autoDispose<InternetStatus>((
  ref,
) {
  return InternetConnection().onStatusChange;
});

class ConnectionIndicator extends ConsumerWidget {
  const ConnectionIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(internetStatusProvider);
    final connected = status.value == InternetStatus.connected;
    final checking = status.isLoading && !status.hasValue;
    final unknown = status.hasError;
    final colors = Theme.of(context).colorScheme;
    final color = checking || unknown
        ? colors.onSurfaceVariant
        : connected
        ? const Color(0xFF166534)
        : colors.error;
    final label = checking
        ? 'Checking connection…'
        : unknown
        ? 'Connection unavailable'
        : connected
        ? 'Online'
        : 'Offline';
    return Semantics(
      liveRegion: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            checking || unknown
                ? Icons.sync_rounded
                : connected
                ? Icons.wifi_rounded
                : Icons.wifi_off_rounded,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: color, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
