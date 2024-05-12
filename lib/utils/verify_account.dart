import 'package:dio/dio.dart';
import 'package:sasmobile/main.dart';

Future<Response<String>> accountverificiation(acc, pin) async {
  final dio = Dio();
  Future<Response<String>> response = dio.post(url + "/verify",
      data: {"name": acc, "pin": pin},
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }));
  return response;
}
