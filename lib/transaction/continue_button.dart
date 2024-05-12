import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
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
          Obx(() => Text("Empfänger erhält: " + recieval.value)),
          Obx(() => Text("zu Bezahlen:" + topay.value)),
          Obx(
            () => SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.07,
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: FilledButton(
                    onPressed: isClickable()
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
                              var response;
                              var _payment;
                              print(id +
                                  textPartner.value +
                                  amountText.value +
                                  pin);

                              if (hasTaxes.isFalse) {
                                _payment = (Decimal.parse(amountText.value) *
                                        Decimal.parse("1.1"))
                                    .toString();
                              } else {
                                _payment = (Decimal.parse(amountText.value))
                                    .toString();
                              }
                              Get.defaultDialog(
                                  title: "Laden...",
                                  content: CircularProgressIndicator());
                              response = await pay(
                                  id, textPartner.value, _payment, pin);
                              Get.back();
                              if (response.statusCode == 200) {
                                Get.snackbar("Erfolgreich bezahlt:",
                                    "Bezahlt: " + _payment + "D",
                                    icon: Icon(
                                      Icons.check_circle_outline_sharp,
                                      color: Colors.green,
                                      size: 40,
                                    ));
                                bool canVibrate = await Vibrate.canVibrate;
                                if (canVibrate) {
                                  Vibrate.vibrate();
                                }
                              } else {
                                Get.snackbar(
                                    "Fehler!", "Keine Bezahlung möglich");
                              }
                            } else {
                              RxString __pin = "".obs;
                              Get.defaultDialog(
                                  title: "PIN:",
                                  content: Column(
                                    children: [
                                      TextField(
                                        onChanged: (value) {
                                          __pin.value = value;
                                        },
                                        obscureText: true,
                                      ),
                                      Obx(() => TextButton(
                                          onPressed: __pin.value.length == 4 &&
                                                  int.tryParse(__pin.value) !=
                                                      null
                                              ? () async {
                                                  Get.defaultDialog(
                                                      title: "Laden...",
                                                      content:
                                                          CircularProgressIndicator());
                                                  var _payment;
                                                  var response;
                                                  if (hasTaxes.isFalse) {
                                                    _payment = (Decimal.parse(
                                                                amountText
                                                                    .value) *
                                                            Decimal.parse(
                                                                "1.1"))
                                                        .toString();
                                                  } else {
                                                    _payment = (Decimal.parse(
                                                            amountText.value))
                                                        .toString();
                                                  }
                                                  response = await pay(
                                                      textPartner.value,
                                                      id,
                                                      _payment,
                                                      __pin.value);
                                                  Get.back();
                                                  print(response.statusCode);
                                                  if (response.statusCode ==
                                                      200) {
                                                    Get.back();
                                                    Get.snackbar(
                                                        "Erfolgreich empfangen! ",
                                                        "Bezahlt: " +
                                                            _payment +
                                                            "D",
                                                        icon: Icon(
                                                          Icons
                                                              .check_circle_outline_sharp,
                                                          color: Colors.green,
                                                          size: 40,
                                                        ));
                                                    ();
                                                    bool canVibrate =
                                                        await Vibrate
                                                            .canVibrate;
                                                    if (canVibrate) {
                                                      Vibrate.vibrate();
                                                    }
                                                  } else {
                                                    Get.snackbar("Fehler!",
                                                        "Keine Bezahlung möglich");
                                                  }
                                                }
                                              : null,
                                          child: Text("Weiter")))
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

bool isClickable() {
  if (textPartner.value == id) {
    return false;
  }
  if ((amountText.value != "") && (textPartner.value != "")) {
    var val = Decimal.tryParse(amountText.value);
    if (val != null) {
      if (val != Decimal.fromInt(0) && val > Decimal.fromInt(0)) {
        return true;
      }
    }
  }
  return false;
}

RxString calculateRecieval() {
  if (!isClickable()) {
    return "".obs;
  }
  if (!withTax) {
    return (amountText.value + "D").obs;
  } else {
    var amountDoub = Decimal.parse(amountText.value);
    return ((amountDoub / Decimal.parse("1.1")).toString() + "D")
        .obs;
  }
}

RxString calculateToPay() {
  print(withTax);
  if (!isClickable()) {
    return ("").obs;
  }
  if (!withTax) {
    var amountDoub = Decimal.parse(amountText.value);
    return ((amountDoub * Decimal.parse("1.1")).toString() + "D").obs;
  } else {
    return (amountText.value + "D").obs;
  }
}
