import 'package:flutter/material.dart';
bool withTax = false;

class Amount extends StatefulWidget {
  const Amount({
    super.key,
  });

  @override
  State<Amount> createState() => _AmountState();
}

class _AmountState extends State<Amount> {

  @override
  Widget build(BuildContext context) {
    return 
       Padding(
         padding: const EdgeInsets.only(top: 10),
         child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.70,
            child: TextField(decoration: InputDecoration( border: OutlineInputBorder(), suffixIcon: Icon(Icons.attach_money), labelText: withTax ? 'Betrag (mit Steuer):' : "Betrag (ohne Steuer):"),)), SizedBox(
              child: IconButton(iconSize:30, color: Color(0xFF2F537D), onPressed: (){
                  withTax = !withTax;
                  setState((){

                  });
              }, icon: Icon(Icons.swap_horizontal_circle_outlined)),)],
             ),
       );
  }
}
