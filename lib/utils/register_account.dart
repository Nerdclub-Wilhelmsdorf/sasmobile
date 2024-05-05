//TODO: Make use of Keychain to store the account details
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sasmobile/main.dart';

void registerAccount(name, _pin) {
  final box = GetStorage();
  box.write("isInitial", "false");
  box.write("accountName", name);
  box.write("accountPin", _pin);
  pin = _pin;
  id = name;
}

List<String >getAccountData() {
  final box = GetStorage();
  return [box.read("accountName"), box.read("accountPin")];
}