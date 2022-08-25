
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proplus/constants/constants.dart';
import 'package:proplus/utils.dart';

enum UrlType { get, post }

class DioService {

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
      Utils.showSnackBar("Please enter Correct username password");
    }
    return response?.data;
  }
}
