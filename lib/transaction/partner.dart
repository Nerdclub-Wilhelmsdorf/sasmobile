import 'package:flutter/material.dart';
import "package:get/get.dart";
import "package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart";
import "package:sasmobile/transaction/amount.dart";
import "package:sasmobile/transaction/toggle.dart";
import "package:sasmobile/transaction/transaction.dart";

RxString textPartner = "".obs;

class Partner extends StatefulWidget {
  const Partner({
    super.key,
  });

  @override
  State<Partner> createState() => _PartnerState();
}

var partnercontroller = TextEditingController();

class _PartnerState extends State<Partner> {
  var codescanner = QrBarCodeScannerDialog();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.70,
              child: const TextFieldPartner()),
          SizedBox(
            child: IconButton(
                iconSize: 30,
                color: const Color(0xFF2F537D),
                onPressed: () {
                  codescanner.getScannedQrBarCode(
                      context: context,
                      onCode: (code) {
                        if (code!.substring(0, 2) == "w:") {
                          partnercontroller.text =
                              code.substring(2, code.length);
                          textPartner.value = code.substring(2, code.length);
                          updateVals();
                        }
                      });
                },
                icon: const Icon(Icons.qr_code)),
          )
        ],
      ),
    );
  }
}

class TextFieldPartner extends StatelessWidget {
  const TextFieldPartner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextField(
          onChanged: (value) {
            textPartner.value = value;
            updateVals();
          },
          controller: partnercontroller,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixIcon: const Icon(Icons.account_circle_outlined),
              labelText: transactionType.value == TransactionType.expense
                  ? 'Empfänger:'
                  : 'Sender:'),
        ));
    //TextField(decoration: InputDecoration( border: OutlineInputBorder(), suffixIcon: Icon(Icons.account_circle_outlined), labelText: transactionType.value == TransactionType.expense ? 'Sender:' : 'Empfänger:'),);
  }
}
