import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sasmobile/account/history.dart';
import 'package:sasmobile/initial/initial_screen.dart';
import 'package:sasmobile/routes.dart';
import "package:sasmobile/theme.dart";
import 'package:sasmobile/utils/disable_screenshot.dart';
import 'package:sasmobile/utils/ping.dart';
import 'package:sasmobile/utils/register_account.dart';

const url = "https://banking.saswdorf.de";
String pin = "";
String id = "";
const token = "W_97xyk8G]]w";

String version() {
  return "0.2.1";
}
void main() async {
  await GetStorage.init();
  if (!isInitialStart()) {
    var data = await getAccountData();
    id = data[0];
    pin = data[1];
  }
  Get.put(HistoryController());
  var canConnect = await ping();
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MainPage(hasConnection: canConnect));
}

class MainPage extends StatefulWidget {
  final bool hasConnection;
  const MainPage({super.key, required this.hasConnection});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState()  {
    disableScreenshot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: const MaterialThemeCustom(TextTheme()).light(),
      darkTheme: const MaterialThemeCustom(TextTheme()).dark(),
      initialRoute: !widget.hasConnection
          ? "/loading"
          : isInitialStart()
              ? "/login"
              : '/home',
      getPages: appRoutes(),
    );
  }
}
