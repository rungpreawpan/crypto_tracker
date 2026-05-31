import 'package:crypto_tracker/core/utils/currency_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formats standard currency values', () {
    final formatted = CurrencyFormatter.standard(1234.56, symbol: r'$');

    expect(formatted, contains('1,234.56'));
  });
}
