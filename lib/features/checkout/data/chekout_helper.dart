import 'dart:developer';

import 'package:bkash/bkash.dart';
import 'package:get/get.dart';

final bkash = Bkash(logResponse: true);

/// Amount for payment
double amount = 10.0;

/// Function to handle button tap
void onButtonTap(String selected) async {
  switch (selected) {
    case 'bkash':
      await bkashPayment();
      break;
    default:
      log('Unknown payment method selected');
  }
}

/// BKash Payment Process
Future<void> bkashPayment() async {
  try {
    final response = await bkash.pay(
      context: Get.context!,
      amount: amount,
      merchantInvoiceNumber: 'xx551316',
    );
    log('Transaction ID: ${response.trxId}');
    log('Payer Reference: ${response.payerReference}');
    Get.snackbar(
      'Payment Success',
      'Transaction ID: ${response.trxId}',
      snackPosition: SnackPosition.BOTTOM,
    );
  } on BkashFailure catch (e) {
    log('Payment Failed: ${e.toString()}');
    Get.snackbar(
      'Payment Failed',
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
