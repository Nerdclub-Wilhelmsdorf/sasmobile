import 'package:flutter/material.dart';
import 'package:sasmobile/transaction/continue_button.dart';

class TextFieldNumber extends StatelessWidget {
  final String? text;
  const TextFieldNumber({
    this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style:  ButtonStyle(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory
      
      ),

      onPressed: () {
        pin.value = pin.value + text!;
        pincontroller.text = pin.value;
    }, child: Text(this.text ?? ''));
  }
}

class Remove extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextButton(
      
      onPressed: () {
        if (pin.value.length == 0){
          return;
        }
        pin.value = pin.value.substring(0, pin.value.length - 1);
        pincontroller.text = pin.value;
    }, child:const  Text("←", style: TextStyle(color:  Color.fromARGB(255, 187, 74, 74))));
  }
}
class Clear extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextButton(
      
      onPressed: () {
        pin.value = "";
        pincontroller.text = pin.value;
    }, child: const Text("C", style: TextStyle(color:  Color.fromARGB(255, 187, 74, 74) )));
  }
}
