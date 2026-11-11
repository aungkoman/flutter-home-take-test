/// Formats product prices consistently in Myanmar kyat.
String formatMmk(double? value) {
  if (value == null) return 'Price unavailable';
  final parts = value
      .toStringAsFixed(value == value.truncateToDouble() ? 0 : 2)
      .split('.');
  final amount = parts.first.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]},',
  );
  return '$amount${parts.length > 1 ? '.${parts[1]}' : ''} MMK';
}
