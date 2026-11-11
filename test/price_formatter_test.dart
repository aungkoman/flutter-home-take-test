import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/core/utils/price_formatter.dart';

void main() {
  test('MMK labels group whole amounts and retain decimal fractions', () {
    expect(formatMmk(2500), '2,500 MMK');
    expect(formatMmk(1234567.25), '1,234,567.25 MMK');
    expect(formatMmk(0), '0 MMK');
    expect(formatMmk(null), 'Price unavailable');
  });
}
