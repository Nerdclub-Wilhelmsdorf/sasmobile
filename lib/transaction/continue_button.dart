
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasmobile/transaction/amount.dart';
import 'package:sasmobile/transaction/partner.dart';
class ContinueButton extends StatefulWidget {
  const ContinueButton({
    super.key,
  });

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}
var topay = "".obs;
var recieval = "".obs;
class _ContinueButtonState extends State<ContinueButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: 
      
      Column(
        children: [
          Obx(() => Text("Empfänger erhält: " + recieval.value)),
          Obx(() => Text("zu Bezahlen:" + topay.value)),
          Obx(
            () => SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.07,
              width: MediaQuery.sizeOf(context).width*0.5,
              child: FilledButton(onPressed: 
              isClickable() ? 
              (){
                  
              }:
              null,child: Text("Weiter", textScaler: TextScaler.linear(1.4),))),
          ),
        ],
      ),
    );
  }
}

bool isClickable() {
  if((amountText.value != "")&&(textPartner.value != "")) {
    var val = double.tryParse(amountText.value);
      if(val != null){
        if(val != 0) {
          return true;
        }
      }
  }
  return false;
}

RxString calculateRecieval() {
  if(!isClickable()) {
    return "".obs;
  }
  if (!withTax) {
    return (amountText.value + "D").obs;
  }else{
    var amountDoub = double.parse(amountText.value);
    return ((amountDoub - amountDoub * 0.1).toString() + "D").obs; 
  }
}

RxString calculateToPay() {
  print(withTax);
  if(!isClickable()) {
    return ("").obs;
  }
  if (!withTax) {
    var amountDoub = double.parse(amountText.value);
    return ((amountDoub * 1.1).toString() + "D").obs;
  }else{
    return (amountText.value + "D").obs; 
  }
}
