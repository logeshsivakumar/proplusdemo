


import 'package:flutter/material.dart';
import 'package:proplus/model/particularproductmodel.dart';
import 'package:proplus/model/productlistmodel.dart';
import 'package:proplus/repository/productlistrepository.dart';


class ProductListViewModel extends ChangeNotifier{
  ProductListRepository productListRepository =ProductListRepository();

  Future<List<ProductListModel>> fetchProductData() async{
    var response = await productListRepository.fetchProductData();
    var jsonRes = response as List;
    var obj = jsonRes.map((e) => ProductListModel.fromJson(e)).toList();
    return obj;
  }

  Future<ParticularProductModel> fetchSelectedProductData(String id) async{
    var response = await  productListRepository.fetchSelectedProductData(id);
    var obj=ParticularProductModel.fromJson(response);
    return obj;
  }
}