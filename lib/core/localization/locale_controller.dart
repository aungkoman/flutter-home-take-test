import 'package:flutter/material.dart';

/// UI-only locale selection. No persistence or external dependencies.
class LocaleController {
  LocaleController._();
  static final ValueNotifier<Locale?> current = ValueNotifier<Locale?>(null);

  static void select(Locale? locale) => current.value = locale;
}
