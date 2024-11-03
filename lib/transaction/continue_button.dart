import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:sasmobile/main.dart';
import 'package:sasmobile/transaction/pin_input_field.dart';
import 'package:vibration/vibration.dart';
import 'package:sasmobile/transaction/amount.dart';
import 'package:sasmobile/transaction/partner.dart';
import 'package:sasmobile/transaction/toggle.dart';
import 'package:sasmobile/transaction/transaction.dart';

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
var pincontroller = TextEditingController();
RxString pin = "".obs;
class _ContinueButtonState extends State<ContinueButton> {
  final LocalAuthentication auth = LocalAuthentication();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          Obx(() => Text("Sender bezahlt: ${topay.value}")),
          Obx(() => Text("Empfänger erhält: ${recieval.value}")),
          Obx(
            () => SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.07,
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: FilledButton(
                    onPressed: isClickable.isTrue
                        ? () async {
                            if (transactionType.value ==
                                TransactionType.expense) {
                              bool didAuthenticate = false;

                              try {
                                didAuthenticate = await auth.authenticate(
                                    localizedReason:
                                        'Bitte Authentifiziere dich, um zu bezahlen.',
                                    options: const AuthenticationOptions(
                                        useErrorDialogs: false));
                                // ···
                              } on PlatformException catch (e) {
                                if (e.code == auth_error.notAvailable) {
                                  Get.snackbar(
                                      "Fehler!", "Nicht Authorisiert.");
                                  return;
                                } else if (e.code == auth_error.notEnrolled) {
                                  Get.snackbar(
                                      "Fehler!", "Nicht Authorisiert.");
                                  return;
                                } else {
                                  Get.snackbar(
                                      "Fehler!", "Nicht Authorisiert.");
                                  return;
                                }
                              }
                              if (!didAuthenticate) {
                                Get.snackbar("Fehler!", "Nicht Authorisiert.");
                                return;
                              }
                              // ignore: prefer_typing_uninitialized_variables
                              var response;
                              String payment;

                                payment = (Decimal.parse(amountText.value))
                                    .toString();
                      
                              Get.defaultDialog(
                                  title: "Laden...",
                                  onCancel: null,
                                  barrierDismissible: false,
                                  onWillPop: () => Future.value(false),
                                  content: const CircularProgressIndicator());
                              response = await pay(
                                  id, textPartner.value, amountText.value, pin);
                              print(response.data);
                              Get.back();
                              if (response.statusCode == 200) {
                                clearTransactionFields();
                                Get.snackbar("Erfolgreich bezahlt:",
                                    "Bezahlt: ${payment}D",
                                    icon: const Icon(
                                      Icons.check_circle_outline_sharp,
                                      color: Colors.green,
                                      size: 40,
                                    ));
                                bool? canVibrate = await Vibration.hasVibrator();
                                if (canVibrate != null && canVibrate) {
                                  Vibration.vibrate();
                                }
                              } else {
                                if (response.data
                                    .toString()
                                    .contains("suspended")) {
                                  Get.snackbar("Fehler!",
                                      "Konto gesperrt! Versuchen Sie es später nocheinmal");
                                  return;
                                }

                                if (response.data
                                    .toString()
                                    .contains("error no row")) {
                                  Get.snackbar(
                                      "Fehler!", "Nutzer existiert nicht");
                                } else if (response.data
                                    .toString()
                                    .contains("insufficient funds")) {
                                  Get.snackbar(
                                      "Fehler!", "Nicht genügend Geld");
                                } else {
                                  Get.snackbar(
                                      "Fehler!", "Keine Bezahlung möglich");
                                }
                              }
                            } else {

                              Get.defaultDialog(
                                  title: "PIN:",
                                  content: Column(
                                    children: [
                                      TextField(
                                        readOnly: true,
                                        onChanged: (value) {
                                          pin.value = value;
                                        },
                                        controller: pincontroller,
                                        obscureText: true,
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextFieldNumber(text: "1"),
                                          TextFieldNumber(text: "2"),
                                          TextFieldNumber(text: "3"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextFieldNumber(text: "4"),
                                          TextFieldNumber(text: "5"),
                                          TextFieldNumber(text: "6"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextFieldNumber(text: "7"),
                                          TextFieldNumber(text: "8"),
                                          TextFieldNumber(text: "9"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Clear(),
                                          TextFieldNumber(text: "0"),
                                          Remove(),
                                        ],
                                      ),
                                  
                                      Obx(() => TextButton(
                                          onPressed: pin.value.length == 4 &&
                                                  int.tryParse(pin.value) !=
                                                      null
                                              ? () async {
                                                  Get.defaultDialog(
                                                      title: "Laden...",
                                                      onCancel: null,
                                                      barrierDismissible: false,
                                                      onWillPop: () =>
                                                          Future.value(false),
                                                      content:
                                                          const CircularProgressIndicator());
                                                  String payment;
                                                  // ignore: prefer_typing_uninitialized_variables
                                                  var response;
                                                  if (hasTaxes.isFalse) {
                                                    payment = amountText.value;
                                                  } else {
                                                    payment = (Decimal.parse(
                                                            amountText.value))
                                                        .toString();
                                                  }
                                                  response = await pay(
                                                      textPartner.value,
                                                      id,
                                                      amountText.value,
                                                      pin.value);
                                                  Get.back();
                                                  print(response.data);
                                                  pincontroller.text = "";
                                                  pin.value = "";
                                                  if (response.statusCode ==
                                                      200) {
                                                    Get.back();
                                                    clearTransactionFields();
                                                    Get.snackbar(
                                                        "Erfolgreich empfangen! ",
                                                        "Bezahlt: ${payment}D",
                                                        icon: const Icon(
                                                          Icons
                                                              .check_circle_outline_sharp,
                                                          color: Colors.green,
                                                          size: 40,
                                                        ));
                                                    ();
                                                    bool? canVibrate =
                                                        await Vibration.hasVibrator();
                                                    if (canVibrate != null &&
                                                        canVibrate) {
                                                      Vibration.vibrate();
                                                    }
                                                    return;
                                                  } else {
                                                    Get.back();

                                                    if (response.data
                                                        .toString()
                                                        .contains(
                                                            "suspended")) {
                                                      Get.snackbar("Fehler!",
                                                          "Konto gesperrt! Versuchen Sie es später nocheinmal");
                                                      return;
                                                    }
                                                    if (response.data
                                                        .toString()
                                                        .contains(
                                                            "wrong pin")) {
                                                      Get.snackbar("Fehler!",
                                                          "Falsche PIN");
                                                      return;
                                                    }
                                                    if (response.data
                                                        .toString()
                                                        .contains(
                                                            "error no row")) {
                                                      Get.snackbar("Fehler!",
                                                          "Nutzer existiert nicht");
                                                    } else if (response.data
                                                        .toString()
                                                        .contains(
                                                            "insufficient funds")) {
                                                      Get.snackbar("Fehler!",
                                                          "Nicht genügend Geld");
                                                    } else {
                                                      Get.snackbar("Fehler!",
                                                          "Keine Bezahlung möglich");
                                                    }
                                                  }
                                                }
                                              : null,
                                          child: const Text("Weiter")))
                                    ],
                                  ));
                            }
                          }
                        : null,
                    child: const Text(
                      "Weiter",
                      textScaler: TextScaler.linear(1.4),
                    ))),
          ),
        ],
      ),
    );
  }
}


RxBool isClickable = false.obs;
void setIsClickable() {
  if (textPartner.value == id) {
    isClickable.value = false;
    return;
  }
  if ((amountText.value != "") && (textPartner.value != "")) {
    var val = Decimal.tryParse(amountText.value);
    if (val != null) {
      if (val != Decimal.fromInt(0) && val > Decimal.fromInt(0)) {
        isClickable.value = true;
        return;
      }
    }
  }
  isClickable.value = false;
  return;
}

RxString calculateRecieval() {
  setIsClickable();
  if (isClickable.isFalse) {
    return "".obs;
  }
    var amountDoub = Decimal.parse(amountText.value);
    var output = amountDoub - (amountDoub * Decimal.parse("0.1"));
    return (("${output}D").obs);
  }


RxString calculateToPay() {
  setIsClickable();
  if (isClickable.isFalse) {
    return ("").obs;
  }

    return ("${amountText.value}D").obs;

}

clearTransactionFields() {
  amountcontroller.text = "";
  partnercontroller.text = "";
  amountText.value = "";
  textPartner.value = "";
  updateVals();
}
