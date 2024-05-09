import 'package:dio/dio.dart';
import 'package:sasmobile/main.dart';

Future<Response<String>> getBalance() async {
  final dio = Dio();
  Future<Response<String>> response = dio.post(url + "/balanceCheck",
      data: {"acc1": id, "pin": pin},
      options: Options(headers: {
        "Authorization": "Bearer " + token,
      }));
  return response;
}
