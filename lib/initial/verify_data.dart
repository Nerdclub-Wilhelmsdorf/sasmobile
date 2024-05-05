
import 'package:sasmobile/initial/first_account.dart';
import 'package:sasmobile/initial/first_account_pin.dart';

bool verifyFields() {
  if(ValueAccountPin.length != 4) {
    return false;
  }
  if(int.tryParse(ValueAccountPin) == null) {
    return false;
  }
  if(ValueAccount == "") {
    return false;
  }
  return true;
}