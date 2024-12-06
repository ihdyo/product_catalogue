import 'package:intl/intl.dart';

class Formatter {

  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(amount);
  }

}