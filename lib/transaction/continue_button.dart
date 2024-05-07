
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sasmobile/initial/first_account.dart';
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
  SupportState _supportState = SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  @override
  void initState() {
super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? SupportState.supported
              : SupportState.unsupported),
        );
    super.initState();
  }
  
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
                await _authenticate();
                if (_authorized != "Authorized") {
                  Get.snackbar("Fehler!", "Nicht Authorisiert.");
                  return;
                }
                if(transactionType.value == TransactionType.expense){
                   var response;
                   var _payment;
                  print(id + textPartner.value + amountText.value + pin);
                  if(hasTaxes.isFalse){
                    _payment = (Decimal.parse(amountText.value) * Decimal.parse("1.1")).toString();
                  } else {
                    _payment = (Decimal.parse(amountText.value) * Decimal.parse("1.1")).toString();
                  }
                    response = await pay(id, textPartner.value,_payment, pin);
                   if(response.statusCode == 200) {
                    Get.snackbar("Erfolgreich bezahlt:", "Bezahlt: " + _payment + "D",

                    icon: Icon(Icons.check_circle_outline_sharp, color: Colors.green, size: 40,)
                    );  
                  bool canVibrate = await Vibrate.canVibrate;
                  if(canVibrate) {
                    Vibrate.vibrate();
                  }
                   }else{
                    Get.snackbar("Fehler!", "Keine Bezahlung möglich");
                   }
                   } else {

                   }
              }:
              null,child: const Text("Weiter", textScaler: TextScaler.linear(1.4),))),
          ),
        ],
      ),
    );
  }
  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authentifizieren';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Authentifiziere dich, um zu bezahlen',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }


}

bool isClickable() {
  if((amountText.value != "")&&(textPartner.value != "")) {
    var val = Decimal.tryParse(amountText.value);
      if(val != null){
        if(val != Decimal.fromInt(0) && val > Decimal.fromInt(0)) {
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
    var amountDoub = Decimal.parse(amountText.value);
    return ((amountDoub - amountDoub * Decimal.parse("0.1")).toString() + "D").obs; 
  }
}

RxString calculateToPay() {
  print(withTax);
  if(!isClickable()) {
    return ("").obs;
  }
  if (!withTax) {
    var amountDoub = Decimal.parse(amountText.value);
    return ((amountDoub * Decimal.parse("1.1")).toString() + "D").obs;
  }else{
    return (amountText.value + "D").obs; 
  }
}
