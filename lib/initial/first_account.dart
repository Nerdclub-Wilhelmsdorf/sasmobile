import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sasmobile/initial/continue_account_setup.dart';
import 'package:sasmobile/initial/verify_data.dart';

var ValueAccount = "";
var ControllerAccount = TextEditingController();

class RegisterFirstAccount extends StatefulWidget {
  const RegisterFirstAccount({
    super.key,
  });

  @override
  State<RegisterFirstAccount> createState() => _RegisterFirstAccountState();
}

class _RegisterFirstAccountState extends State<RegisterFirstAccount> {
  final codescanner = QrBarCodeScannerDialog();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.85,
              child: TextFieldAccount()),
          IconButton(
              iconSize: 30,
              color: Color(0xFF2F537D),
              onPressed: () {
                codescanner.getScannedQrBarCode(
                    context: context,
                    onCode: (code) {
                      if (code!.substring(0, 2) == "w:") {
                        ControllerAccount.text = code.substring(2, code.length);
                      }
                    });
              },
              icon: Icon(Icons.qr_code)),
        ],
      ),
    );
  }
}

class TextFieldAccount extends StatelessWidget {
  const TextFieldAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: ControllerAccount,
        onChanged: (value) {
          ValueAccount = value;
          canContinue.value = verifyFields();
        },
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.account_circle_outlined),
            labelText: "Konto"));
    //TextField(decoration: InputDecoration( border: OutlineInputBorder(), suffixIcon: Icon(Icons.account_circle_outlined), labelText: transactionType.value == TransactionType.expense ? 'Sender:' : 'Empfänger:'),);
  }
}
