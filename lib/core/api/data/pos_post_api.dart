import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../../models/pos_sales_model/sales_model.dart';
import '../../interceptor/app_dio.dart';

class PostPosApi {
  Future postPosApi({required List<PosSalesModel>? data}) async {
    const String subUrl = "/api/pos/order/";
    String uri = AppAPI.baseUrl + subUrl;
    final bodyData = json.encode(data);
    final response = await Api().dio.post(
      uri,
      data: bodyData
    );
    final statusCode = response.statusCode;
    final body = response.data;
    if (statusCode == 201 || statusCode == 200) {
      return body;
    }
  }
}