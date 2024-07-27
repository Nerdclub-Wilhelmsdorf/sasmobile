import 'package:dio/dio.dart';
import 'package:sasmobile/main.dart';

Future<bool> ping() async {
  try {
    final dio = Dio();
    var response = await dio.get("$url/",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    if (response.statusCode == 200 && response.data == "0"){
      return true;
    }
    return false;
  } on DioException catch (e) {
    if (e.response != null && e.response!.statusCode == 201) {
      return true;
    }

    return false;
  }
}
