import 'package:flutter/material.dart';
import 'package:sasmobile/initial/continue_account_setup.dart';
import 'package:sasmobile/initial/verify_data.dart';

var ValueAccountPin = "";

class FirstAccountPin extends StatefulWidget {
  const FirstAccountPin({
    super.key,
  });

  @override
  State<FirstAccountPin> createState() => _FirstAccountPinState();
}

class _FirstAccountPinState extends State<FirstAccountPin> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextFieldAccount(),
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
        obscureText: true,
        onChanged: (value) {
          ValueAccountPin = value;
          canContinue.value = verifyFields();
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.account_circle_outlined),
          labelText: "PIN",
        ));
    //TextField(decoration: InputDecoration( border: OutlineInputBorder(), suffixIcon: Icon(Icons.account_circle_outlined), labelText: transactionType.value == TransactionType.expense ? 'Sender:' : 'Empfänger:'),);
  }
}
