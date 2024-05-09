import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sasmobile/account/account.dart';
import 'package:sasmobile/display_qr/qr_page.dart';
import 'package:sasmobile/initial/initial_screen.dart';
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
          onDestinationSelected: (int index) {
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
