import 'package:flutter_local_authentication/flutter_local_authentication.dart';
import 'package:get/get.dart';

Future<bool> authenticate(FlutterLocalAuthentication _flutterLocalAuthenticationPlugin) async {
    bool canAuthenticate;
    try {
      // Query suppor for Local Authentication
      canAuthenticate = await _flutterLocalAuthenticationPlugin.canAuthenticate();

      // Setup TouchID Allowable Reuse duration
      // It works only in iOS and macOS, but it's safe to call it even on other platforms.
      await _flutterLocalAuthenticationPlugin.setTouchIDAuthenticationAllowableReuseDuration(30);
    } on Exception catch (error) {
      canAuthenticate = false;
      Get.snackbar("Fehler", "Keine Authentifizierung möglich, kein !");
      return false;
    }

    if (canAuthenticate) {
      // Perform Local Authentication

      _flutterLocalAuthenticationPlugin.authenticate().then((authenticated) {
        String result = 'Authenticated: $authenticated';
        return true;
      }).catchError((error) {
        String result = 'Exception: $error';
        Get.snackbar("Fehler", "Keine Authentifizierung möglich!");
        return false;
      });
    }
  return false;
}