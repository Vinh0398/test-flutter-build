import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String moneyString(int number, String currency, {String? locale}) {
    final formatter = NumberFormat.currency(
      locale: locale ?? 'en_US',
      symbol: currency,
      decimalDigits: 0,
    );

    try {
      if (number >= 0) {
        return formatter.format(number);
      } else {
        return '-${formatter.format(number.abs())}';
      }
    } catch (e) {
      // Fallback if formatting fails
      final symbol = currency;
      final absNumber = number.abs().toStringAsFixed(2);
      return number >= 0 ? '$symbol$absNumber' : '- $symbol$absNumber';
    }
  }
}
