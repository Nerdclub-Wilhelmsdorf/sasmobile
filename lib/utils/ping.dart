import 'package:dio/dio.dart';
import 'package:sasmobile/main.dart';

Future<bool> ping() async {
  try {
    final dio = Dio();
    var response = await dio.get("$url/",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    if (response.statusCode == 200 && response.data == "0") {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}
