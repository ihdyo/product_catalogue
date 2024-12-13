class IDBuilder {

  static String orderId(String recipient, String address) {
    final ids = <String>[];
    ids.add(recipient.substring(0,3).toLowerCase());
    ids.add(address.substring(0,3).toLowerCase());
    return '${ids.join('_')}_${DateTime.now().millisecondsSinceEpoch}';
  }

}