import 'package:sasmobile/initial/first_account.dart';
import 'package:sasmobile/initial/first_account_pin.dart';

bool verifyFields() {
  if (valueaccountpin.length != 4) {
    return false;
  }
  if (int.tryParse(valueaccountpin) == null) {
    return false;
  }
  if (valueaccount == "") {
    return false;
  }
  return true;
}
