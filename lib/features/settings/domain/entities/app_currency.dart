enum AppCurrency { usd, thb, eur }

extension AppCurrencyExtension on AppCurrency {
  String get code {
    return name;
  }

  String get displayCode {
    return name.toUpperCase();
  }

  String get symbol {
    if (this == AppCurrency.thb) {
      return '฿';
    }

    if (this == AppCurrency.eur) {
      return '€';
    }

    return r'$';
  }
}
