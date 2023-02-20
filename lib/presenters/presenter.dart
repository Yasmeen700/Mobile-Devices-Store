import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta_gate_test/constants/end_point.dart';
import 'package:meta_gate_test/models/products_model.dart';
import 'package:meta_gate_test/presenters/view_interface.dart';
import 'package:http/http.dart';

class DevicesController extends GetxController implements ViewInterface {
  @override
  void onInit() {
    getAllProducts();
    searchForProduct('');
    super.onInit();
  }

  RxList<Product> products = <Product>[].obs;
  RxList<Product> productsSearchResult = <Product>[].obs;
  ScrollController scrollController = ScrollController();
  Rx<Future> devicesFuture = Future.value().obs;
  Rx<Future> searchFuture = Future.value().obs;

  @override
  Future getAllProducts() async {
    try {
      var response = await get(Uri.parse(EndPoints.getAllProducts));
      var x = Products.fromJson(jsonDecode(response.body));
      products.value = x.products ?? [];
      return devicesFuture.value;
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Future searchForProduct(String value) async {
    try {
      var response = await get(Uri.parse(EndPoints.searchForProducts+value));
      var x = Products.fromJson(jsonDecode(response.body));
      productsSearchResult.value = x.products ?? [];
      productsSearchResult.removeWhere((element) => element.id! >= 30);
      return searchFuture.value;
    } catch (e) {
    }
  }

  calculateNewPrice(int? oldPrice, double? discount) {
    var discountValue = ((oldPrice ?? 0) * (discount ?? 0)) / 100;
    return (oldPrice ?? 0) - discountValue;
  }
}
