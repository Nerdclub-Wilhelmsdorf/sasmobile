
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_local_authentication/flutter_local_authentication.dart';
import 'package:flutter_local_authentication/localization_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sasmobile/main.dart';
import 'package:sasmobile/transaction/amount.dart';
import 'package:sasmobile/transaction/partner.dart';
import 'package:sasmobile/transaction/toggle.dart';
import 'package:sasmobile/transaction/transaction.dart';
import 'package:sasmobile/utils/authenticate.dart';
import 'package:sasmobile/utils/pay.dart';
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
              () async {
                if(transactionType.value == TransactionType.expense){
                  final _flutterLocalAuthenticationPlugin = FlutterLocalAuthentication();
                  final localization = LocalizationModel(
                  promptDialogTitle: "Authentifizierung",
                  promptDialogReason: "Authentifiziere dich, um eine Transaktion durchzuführen",
                   cancelButtonTitle: "Abbrechen"
                   );
                  _flutterLocalAuthenticationPlugin.setLocalizationModel(localization);
                  bool isAuthenticated = await authenticate(_flutterLocalAuthenticationPlugin);
                  if(isAuthenticated) {
                   var response; 
                   if(hasTaxes.isFalse) {
                   response = await pay(id,textPartner.value, double.parse(amountText.value) * 1.1, pin);
                   
                   if(response.statusCode == 200) {
                    Get.snackbar("Erfolgreich bezahlt:", "Bezahlt: " + (double.parse(amountText.value) * 1.1).toString());
                   }
                   }
                  }
                }
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
