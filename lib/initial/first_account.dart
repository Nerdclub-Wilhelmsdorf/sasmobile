
import 'package:flutter/material.dart';

class RegisterFirstAccount extends StatefulWidget {
  const RegisterFirstAccount({
    super.key,
  });

  @override
  State<RegisterFirstAccount> createState() => _RegisterFirstAccountState();
}

class _RegisterFirstAccountState extends State<RegisterFirstAccount> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
           SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.85,
            child: TextFieldAccount()
            ),
          IconButton(iconSize:30, color: Color(0xFF2F537D), onPressed: (){}, icon: Icon(Icons.qr_code)),
      
      
            
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
      onChanged: (value) {
      },
      decoration: const InputDecoration( border: OutlineInputBorder(), suffixIcon: Icon(Icons.account_circle_outlined), labelText: "Konto"));
    //TextField(decoration: InputDecoration( border: OutlineInputBorder(), suffixIcon: Icon(Icons.account_circle_outlined), labelText: transactionType.value == TransactionType.expense ? 'Sender:' : 'Empfänger:'),);
  }
}
