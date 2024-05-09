import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader/loader.dart';
import 'package:sasmobile/account/balance.dart';
import 'package:sasmobile/account/history.dart';
import 'package:sasmobile/utils/get_balance.dart';
import 'package:sasmobile/utils/get_history.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    super.key,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

var balance = "".obs;

class _AccountPageState extends State<AccountPage>
    with LoadingMixin<AccountPage> {
  @override
  Future<void> load() async {
    loadBalance();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              SizedBox(child: Balance()),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.733,
                  width: MediaQuery.sizeOf(context).width,
                  child: History())
            ]),
          );
  }
}
