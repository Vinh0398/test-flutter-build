import 'package:intl/intl.dart';

class NumberUtils {

  NumberUtils._();

  static String formatNumber(num number, int decimalDigits) {
    String pattern = "#,###";
    if (decimalDigits > 0) {
      pattern += ".";
      for (int i = 0; i < decimalDigits; i++) {
        pattern += "#";
      }
    }
    const locale =  "vi_VN";
    final format = NumberFormat(pattern, locale);
    return format.format(number);
  }

  static String formatCurrency(num number, String currency) {
    final symbol = NumberFormat.simpleCurrency(name: currency).currencySymbol;
    return symbol + formatNumber(number, 0);
  }
}