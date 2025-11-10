import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format(number * 1000);
    return formatterNumber;
  }

  static String getDay(DateTime date) {
    return DateFormat('EEEE d', 'en_US').format(date);
  }
}
