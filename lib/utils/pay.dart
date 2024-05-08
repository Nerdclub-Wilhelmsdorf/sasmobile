import 'package:dio/dio.dart';
import 'package:sasmobile/main.dart';

Future<Response<String>> pay(from, to, amount, pin) async {
  final dio = Dio();
  Future<Response<String>> response = dio.post(url + "/pay",
      data: {"acc1": from, "acc2": to, "amount": amount, "pin": pin},
      options: Options(headers: {
        "Authorization": "Bearer " + token,
      }));
  return response;
}
