import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:sasmobile/main.dart';
import 'package:sasmobile/no_internet/login_page.dart';
import 'package:sasmobile/utils/ping.dart';

Future<Response<String>> pay(from, to, amount, pin) async {
  final dio = Dio();
  var connection = await ping();
  if (!connection) {
    stillActive = true;
    Get.toNamed("/loading");
  }
  Future<Response<String>> response = dio.post("$url/pay",
      data: {"from": from, "to": to, "amount": amount, "pin": pin, "purpose": ""},
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }));
  
  return response;
}
