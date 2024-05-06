
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                   if(hasTaxes.isFalse) {
                  response = await pay(id, ValueAccount, (double.parse(amountText.value) * 1.1).toString(), pin);
                   if(response.statusCode == 200) {
                    Get.snackbar("Erfolgreich bezahlt:", "Bezahlt: " + (double.parse(amountText.value) * 1.1).toString());
                   }
                   }
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
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
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
