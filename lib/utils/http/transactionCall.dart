import 'package:product_catalogue/utils/popup/loading.dart';

import '../constant/strings.dart';
import 'htpp.dart';

class TransactionCall {
  static Future<Map<String, dynamic>> createTransaction(Map<String, dynamic> data) async {
    try {
      final response = await Http.post('midtrans-api', data);
      return response;
    } catch (e) {
      Loading.errorSnackBar(title: Strings.error, message: e.toString());
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getTransactionStatus(String orderId) async {
    try {
      final response = await Http.get('check-status/$orderId');
      return response;
    } catch (e) {
      Loading.errorSnackBar(title: Strings.error, message: e.toString());
      rethrow;
    }
  }

}