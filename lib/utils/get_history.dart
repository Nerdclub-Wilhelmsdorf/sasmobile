import 'package:dio/dio.dart';
import 'package:sasmobile/main.dart';

Future<Response<String>> getHistory() async {
  final dio = Dio();
  Future<Response<String>> response = dio.post(url + "/getLogs",
      data: {"acc": id, "pin": pin},
      options: Options(headers: {
        "Authorization": "Bearer " + token,
      }));
  return response;
}
