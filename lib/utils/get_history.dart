import 'package:dio/dio.dart';
import 'package:result_type/result_type.dart';
import 'package:sasmobile/main.dart';

Future<Result<Response<String>, Exception>> getHistory() async {
  /*if (pin == "" && id == "") {
    return Failure(Exception("empty request"));
  }*/
  try {
    final dio = Dio();
    Future<Response<String>> response = dio.post("$url/getLogs",
        data: {"acc": id, "pin": pin},
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }));
    return Success(await response);
  } catch (e) {
    return Failure(Exception("error sending request"));
  }
}
