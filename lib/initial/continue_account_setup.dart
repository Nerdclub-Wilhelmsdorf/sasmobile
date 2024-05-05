
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasmobile/initial/first_account.dart';
import 'package:sasmobile/initial/first_account_pin.dart';
import 'package:sasmobile/initial/verify_data.dart';
import 'package:sasmobile/utils/verify_account.dart';
var canContinue = false.obs;
class ContinueAccountSetup extends StatelessWidget {
  const ContinueAccountSetup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.6,
      height: MediaQuery.sizeOf(context).height * 0.08,
      child: Obx(() => FilledButton(onPressed: canContinue.isTrue ?  () async{
        var response = await AccountVerificiation(ValueAccount, ValueAccountPin);
        if (response.data !="account verified"){
            showFailedDialog(response);
        }
      } : null, child: Text("Weiter", style: TextStyle(fontSize: 18),))));
  }
}

void showFailedDialog(response) async{
  switch(response.data){
    case "account suspended":
          Get.defaultDialog(
            title: "Welcome to Flutter Agency",
            middleText: "We are the best Flutter App Development Company!",
            backgroundColor: Colors.red,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );    case "account does not exist":
      Get.defaultDialog(title: "Konto existiert nicht.");
    case "error verifying account":
      Get.defaultDialog(title:  "Fehler!");
    case "failed to verify account":
      Get.defaultDialog(title:"PIN nicht korrekt!");
    default:
      Get.defaultDialog(title: "Fehler!");
  }
}