import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sasmobile/account/account.dart';
import 'package:sasmobile/account/balance.dart';
import 'package:sasmobile/account/history.dart';
import 'package:sasmobile/display_qr/qr_page.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:sasmobile/transaction/transaction.dart';

class Frame extends StatefulWidget {
  Frame({
    super.key,
  });

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            title: Text(
              "SaS Pay",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            )),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) async {
            if (index == 2 && currentPageIndex != 2) {
              Get.defaultDialog(
                  title: "Laden...", content: CircularProgressIndicator());
              final asyncGroup = FutureGroup();
              asyncGroup.add(loadBalance());
              asyncGroup.add(Get.find<HistoryController>().updateHistory());
              asyncGroup.close();
              await asyncGroup.future;
              Get.back();
              if (!(await authenticateAccountPage())) {
                return;
              }
            }
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.credit_card),
              label: 'Transaktionen',
            ),
            NavigationDestination(icon: Icon(Icons.qr_code), label: "QR-Code"),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Konto',
            ),
          ],
        ),
        body: IndexedStack(
          index: currentPageIndex,
          children: const [
            TransactionPage(),
            QrPage(),
            AccountPage(),
          ],
        ),
      ),
    );
  }
}

authenticateAccountPage() async {
  bool didAuthenticate = false;
  final LocalAuthentication auth = LocalAuthentication();
  try {
    didAuthenticate = await auth.authenticate(
        localizedReason:
            'Bitte Authentifiziere dich, um die Kontodaten einzusehen.',
        options: const AuthenticationOptions(useErrorDialogs: false));
    // ···
  } on PlatformException catch (e) {
    if (e.code == auth_error.notAvailable) {
      Get.snackbar("Fehler!", "Nicht Authorisiert.");
      return false;
    } else if (e.code == auth_error.notEnrolled) {
      Get.snackbar("Fehler!", "Nicht Authorisiert.");
      return false;
    } else {
      Get.snackbar("Fehler!", "Nicht Authorisiert.");
      return false;
    }
  }
  if (!didAuthenticate) {
    Get.snackbar("Fehler!", "Nicht Authorisiert.");
    return false;
  } else {
    return true;
  }
}
