import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../../models/pos_sales_model/sales_model.dart';
import '../interceptor/app_dio.dart';

class CheckINOUTAPI {
  Future checkINOUTAPI({required String data}) async {
    const String subUrl = "/api/pos/checkinout/";
    String uri = AppAPI.baseUrl + subUrl;
    final response = await Api().dio.get(
        uri,
      queryParameters: {
        "type":data,
      }
    );
    final statusCode = response.statusCode;
    final body = response.data;
    if (statusCode == 201 || statusCode == 200) {
      return body;
    }
  }
}