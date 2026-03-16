import 'package:dio/dio.dart';
import 'api_constants.dart';

class ApiClient {

  late Dio dio;

  ApiClient() {

    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

  }

  Future<Response> post(String url, dynamic data) async {

    return await dio.post(url, data: data);

  }

}