import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sasmobile/initial/continue_account_setup.dart';
import 'package:sasmobile/initial/first_account.dart';
import 'package:sasmobile/initial/first_account_pin.dart';
import 'package:sasmobile/initial/welcome_text.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({
    super.key,
  });

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WelcomeText(),
              RegisterFirstAccount(),
              FirstAccountPin(),
              Spacer(flex: 4),
              ContinueAccountSetup(),
              Spacer()
            ],
          )),
    );
  }
}

bool isInitialStart() {
  final box = GetStorage();
  return box.read("isInitial") == null;
}
