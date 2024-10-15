import 'package:no_screenshot/no_screenshot.dart';

final _noScreenshot = NoScreenshot.instance;

void disableScreenshot() async {
  bool result = await _noScreenshot.screenshotOff();
}
