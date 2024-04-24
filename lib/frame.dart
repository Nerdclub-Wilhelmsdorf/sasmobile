import 'package:flutter/material.dart';
import 'package:sasmobile/account/account.dart';
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
    return Scaffold(
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
          AccountPage(),
          ],
      ),
    );
  }
}

