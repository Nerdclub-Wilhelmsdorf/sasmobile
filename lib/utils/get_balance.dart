import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sasmobile/main.dart';
import 'package:sasmobile/no_internet/login_page.dart';
import 'package:sasmobile/utils/ping.dart';

Future<Response<String>> getBalance() async {
  final dio = Dio();
  var connection = await ping();
  if (!connection) {
    stillActive = true;
    Get.toNamed("/loading");
  }
  Future<Response<String>> response = dio.post("$url/balanceCheck",
      data: {"acc1": id, "pin": pin},
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }));
  return response;
}
