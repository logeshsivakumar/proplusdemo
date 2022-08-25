

import 'dart:convert';

import 'package:proplus/constants/constants.dart';
import 'package:proplus/constants/urlconstants.dart';
import 'package:proplus/model/productlistmodel.dart';
import 'package:proplus/service.dart';

class ProductListViewModel{
  DioService _dioService =DioService();

  Future<List<ProductListModel>> fetchProductData() async{
    var response = await _dioService.getHttp(UrlConstants.productListUrl,RequestType.getRequestType);
    var jsonRes = response as List;
    var obj = jsonRes.map((e) => ProductListModel.fromJson(e)).toList();
    return obj;
  }
}