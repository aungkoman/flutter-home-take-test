# Testing and coverage

Parent epic: #53. Baseline: #54. This document describes commands, not an unverified coverage result.

## Run

```sh
flutter pub get
flutter analyze
flutter test
flutter test --coverage
dart run tool/coverage_summary.dart
```

Optionally enforce a minimum after establishing a clean baseline:

```sh
MIN_LINE_COVERAGE=80 dart run tool/coverage_summary.dart
```

The summary uses LCOV `DA` entries for instrumented `lib/` files and excludes generated `.g.dart` and `.freezed.dart` files. The percentage is **line coverage**, not branch coverage or a measure of correctness. Files omitted from LCOV are not counted, so verify instrumentation scope before interpreting the number.

## Test strategy

- Unit tests: validation, formatting, use cases and business rules.
- Provider tests: session restoration, logout failures and routing state.
- In-memory Drift tests: real SQL operations with isolated databases.
- Widget tests: UI rendering, navigation and interaction.
- Planned integration tests (#59): full flows on emulator/device.

Keep fixtures deterministic; test success, failure and boundary cases; close database instances and provider containers in teardown. Do not claim tests pass or a percentage until executed.
