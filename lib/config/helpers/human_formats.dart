import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, [int decimalDigits = 0]) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
    ).format(number);
    return formatterNumber;
  }

  static String getDay(DateTime date) {
    return DateFormat('EEEE d', 'en_US').format(date);
  }
}
