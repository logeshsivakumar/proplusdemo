import 'package:dio/dio.dart';
import 'package:proplus/constants/constants.dart';

enum UrlType { get, post }

class DioService {
  Map<String, dynamic> result = {"username": "mor_2314", "password": "83r5^_"};

  Future<dynamic> getHttp(String baseUrl, String requestType,
      {Map<String, dynamic>? result}) async {
    Response? response;
    try {
      switch (requestType) {
        case RequestType.postRequestType:
          response = await Dio()
              .post('https://fakestoreapi.com/auth/login', data: result);
          break;
        case RequestType.getRequestType:
          response = await Dio().get(baseUrl);
          break;
      }
    } catch (e) {
      print(e);
    }
    return response?.data;
  }
}
