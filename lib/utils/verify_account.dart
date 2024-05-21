import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:sasmobile/main.dart';
import 'package:sasmobile/no_internet/login_page.dart';
import 'package:sasmobile/utils/ping.dart';

Future<Response<String>> accountverificiation(acc, pin) async {
  final dio = Dio();
  var connection = await ping();
  if (!connection) {
    stillActive = true;
    Get.toNamed("/loading");
  }
  Future<Response<String>> response = dio.post(url + "/verify",
      data: {"name": acc, "pin": pin},
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }));
  return response;
}
