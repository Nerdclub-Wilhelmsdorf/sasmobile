import 'package:flutter/material.dart';
import "package:sasmobile/transaction/toggle.dart";
import "package:sasmobile/transaction/transaction.dart";

class Partner extends StatefulWidget {
  const Partner({
    super.key,
  });

  @override
  State<Partner> createState() => _PartnerState();
}

class _PartnerState extends State<Partner> {
  @override
  Widget build(BuildContext context) {
    return 
       Padding(
         padding: const EdgeInsets.only(top: 40),
         child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.70,
            child: TextField(decoration: InputDecoration( border: OutlineInputBorder(), suffixIcon: Icon(Icons.account_circle_outlined), labelText: transactionType == TransactionType.expense ? 'Sender:' : 'Empfänger:'),)), SizedBox(
              child: IconButton(iconSize:30, color: Color(0xFF2F537D), onPressed: (){}, icon: Icon(Icons.qr_code)),)],
             ),
       );
  }
}
