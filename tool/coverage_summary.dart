import 'dart:io';

/// Summarizes LCOV line coverage without counting generated Dart files.
/// Run after: flutter test --coverage
void main(List<String> args) {
  final file = File(args.isEmpty ? 'coverage/lcov.info' : args.first);
  if (!file.existsSync()) {
    stderr.writeln('Missing ${file.path}. Run flutter test --coverage first.');
    exitCode = 2;
    return;
  }

  final records = <String, ({int found, int hit})>{};
  String? path;
  var found = 0;
  var hit = 0;

  void flush() {
    if (path != null &&
        path!.startsWith('lib/') &&
        !path!.endsWith('.g.dart') &&
        !path!.endsWith('.freezed.dart')) {
      records[path!] = (found: found, hit: hit);
    }
    path = null;
    found = 0;
    hit = 0;
  }

  for (final line in file.readAsLinesSync()) {
    if (line.startsWith('SF:')) {
      flush();
      path = line.substring(3).replaceAll('\\', '/');
      final index = path!.indexOf('lib/');
      if (index >= 0) path = path!.substring(index);
    } else if (line.startsWith('DA:')) {
      final parts = line.substring(3).split(',');
      if (parts.length >= 2) {
        found++;
        if ((int.tryParse(parts[1]) ?? 0) > 0) hit++;
      }
    } else if (line == 'end_of_record') {
      flush();
    }
  }
  flush();
  final totals = records.values.fold<(int, int)>(
    (0, 0),
    (sum, value) => (sum.$1 + value.hit, sum.$2 + value.found),
  );
  if (totals.$2 == 0) {
    stderr.writeln('No instrumented lib/ lines found.');
    exitCode = 2;
    return;
  }
  final percent = 100 * totals.$1 / totals.$2;
  stdout.writeln('Line coverage: ${percent.toStringAsFixed(2)}% '
      '(${totals.$1}/${totals.$2})');
  final sorted = records.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  for (final entry in sorted) {
    final value = entry.value;
    final rate = value.found == 0 ? 0 : 100 * value.hit / value.found;
    stdout.writeln('${rate.toStringAsFixed(1).padLeft(6)}% '
        '${value.hit}/${value.found} ${entry.key}');
  }
  final threshold = double.tryParse(
    Platform.environment['MIN_LINE_COVERAGE'] ?? '',
  );
  if (threshold != null && percent < threshold) {
    stderr.writeln('Coverage below required ${threshold.toStringAsFixed(1)}%.');
    exitCode = 1;
  }
}
