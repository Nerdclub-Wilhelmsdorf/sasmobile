import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sasmobile/account/account.dart';
import 'package:sasmobile/utils/get_balance.dart';

class Balance extends StatelessWidget {
  const Balance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => AutoSizeText(
          "Kontostand: ${balance.value}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}

Future<String> loadBalance() async {
  var balanceResponse = await getBalance();
  if (balanceResponse.statusCode == 200) {
    balance.value = "${balanceResponse.data!}D";
    return "${balanceResponse.data!}D";
  } else {
    return "";
  }
}
