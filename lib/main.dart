import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sasmobile/initial/initial_screen.dart';
import 'package:sasmobile/routes.dart';
import "package:sasmobile/theme.dart";
import 'package:sasmobile/utils/authenticate.dart';
import 'package:sasmobile/utils/register_account.dart';
const url = "https://saswdorf.de:8443";
const token = "test";
String pin = "";
String id = "";
void main() async{
  await GetStorage.init();
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    if(!isInitialStart()) {
      var data = getAccountData();
      id = data[0];
      pin = data[1];
    }
 
    super.initState();
  

  }
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: const MaterialThemeCustom(TextTheme()).light(),
      darkTheme: const MaterialThemeCustom(TextTheme()).dark(),
      initialRoute: isInitialStart() ? "/login" : '/home',
      getPages: appRoutes(),
    );
  }
}

