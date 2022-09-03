


import 'package:proplus/constants/constants.dart';
import 'package:proplus/constants/urlconstants.dart';
import 'package:proplus/service/apiservice.dart';

class ProductListRepository{

  final DioService _dioService = DioService();

  Future<dynamic> fetchProductData() async{
    var response = await _dioService.getHttp(UrlConstants.productListUrl,RequestType.getRequestType);
    return response;
  }

  Future<dynamic> fetchSelectedProductData(String id) async{
    var response = await _dioService.getHttp(UrlConstants.productDetailUrl,RequestType.getRequestType,id:id);
    return response;
  }

}