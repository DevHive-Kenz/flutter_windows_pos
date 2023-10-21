import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../../models/pos_sales_model/sales_model.dart';
import '../../interceptor/app_dio.dart';

class CategoryPosApi {
  Future categoryPosApi() async {
    const String subUrl = "/api/pos/category";
    String uri = AppAPI.baseUrl + subUrl;
    final response = await Api().dio.get(
        uri,
    );
    final statusCode = response.statusCode;
    final body = response.data;
    if (statusCode == 201 || statusCode == 200) {
      return body;
    }
  }
}