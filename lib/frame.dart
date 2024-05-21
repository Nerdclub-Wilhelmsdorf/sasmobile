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
import 'package:sasmobile/no_internet/login_page.dart';
import 'package:sasmobile/transaction/transaction.dart';
import 'package:sasmobile/utils/reset.dart';
import 'package:sasmobile/main.dart';

bool skipAuthentication = false;

class Frame extends StatefulWidget {
  const Frame({
    super.key,
  });

  @override
  State<Frame> createState() => _FrameState();
}

enum MenuIcons { resetsAccounts, version }

class _FrameState extends State<Frame> {
  int currentPageIndex = 0;
  MenuIcons? selectedItem;
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          title: Row(
            children: [
              const Text(
                "SaS Pay",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              PopupMenuButton(
                initialValue: selectedItem,
                onSelected: (MenuIcons item) {
                  setState(() {
                    selectedItem = item;
                    if (item == MenuIcons.resetsAccounts) {
                      Get.defaultDialog(
                          title: "App zurücksetzen",
                          middleText:
                              "Das Konto und die PIN werden vom Gerät entfernt.",
                          confirm: TextButton(
                              onPressed: () => reset(),
                              child: const Text("Bestätigen")));
                    }
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<MenuIcons>>[
                  const PopupMenuItem<MenuIcons>(
                    value: MenuIcons.resetsAccounts,
                    child: Text('Konto zurücksetzten'),
                  ),
                  PopupMenuItem<MenuIcons>(
                    value: null,
                    child: Text("Version: ${version()}"),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) async {
            if (index == 2 && currentPageIndex != 2) {
              Get.defaultDialog(
                  title: "Laden...",
                  onCancel: null,
                  barrierDismissible: false,
                  onWillPop: () => Future.value(false),
                  content: const CircularProgressIndicator());
              try {
                final asyncGroup = FutureGroup();
                asyncGroup.add(loadBalance());
                asyncGroup.add(Get.find<HistoryController>().updateHistory());
                asyncGroup.close();
                await asyncGroup.future;
              } catch (e) {
                stillActive = true;
                Get.toNamed("/loading");
              }

              Get.back();
              if (!skipAuthentication) {
                if (!(await authenticateAccountPage())) {
                  return;
                }
                enableSkip();
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

enableSkip() async {
  skipAuthentication = true;
  await Future.delayed(const Duration(minutes: 15), () {
    skipAuthentication = false;
  });
}
