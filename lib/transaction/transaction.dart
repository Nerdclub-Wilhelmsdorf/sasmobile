import 'package:flutter/material.dart';
import 'package:sasmobile/transaction/partner.dart';
import 'package:sasmobile/transaction/amount.dart';
import 'package:sasmobile/transaction/toggle.dart';
enum TransactionType { income, expense }
class TransactionPage extends StatefulWidget {
  const TransactionPage({
    super.key,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Partner(),
          Amount(),
          Spacer(),
          Toggle()
          
  ],
         
         ),
    );
  }
}



