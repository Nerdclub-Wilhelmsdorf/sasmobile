import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:get_storage/get_storage.dart';

reset() async {
  final box = GetStorage();
  box.remove("isInitial");
  await FlutterKeychain.remove(key: "AccountName");
  await FlutterKeychain.remove(key: "AccountPin");
  FlutterExitApp.exitApp(iosForceExit: true);
}
