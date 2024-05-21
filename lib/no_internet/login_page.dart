import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasmobile/initial/initial_screen.dart';
import 'package:sasmobile/utils/ping.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool stillActive = true;

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      if (stillActive) {
        checkConnection();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.sizeOf(context).width * 0.15,
                width: MediaQuery.sizeOf(context).width * 0.15,
                child: const CircularProgressIndicator()),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "Verbinde zum Server...",
                textScaler: TextScaler.linear(1.2),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void checkConnection() async {
  var hasConnection = await ping();
  if (hasConnection) {
    Get.toNamed(isInitialStart() ? "/login" : '/home');
    stillActive = false;
  }
}
