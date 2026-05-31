import 'package:intl/intl.dart';

class CurrencyFormatter {
  const CurrencyFormatter._();

  static String compact(num? value, {required String symbol}) {
    final formatter = NumberFormat.compactCurrency(
      symbol: symbol,
      decimalDigits: 2,
    );

    return formatter.format(value ?? 0);
  }

  static String standard(num? value, {required String symbol}) {
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: 2);

    return formatter.format(value ?? 0);
  }

  static String percent(num? value) {
    final formatted = NumberFormat.decimalPercentPattern(
      decimalDigits: 2,
    ).format((value ?? 0) / 100);

    return formatted;
  }
}
