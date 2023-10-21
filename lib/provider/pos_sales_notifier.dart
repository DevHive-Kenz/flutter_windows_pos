import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:kenz/constants/constants.dart';
import 'package:kenz/constants/font_manager.dart';
import 'package:kenz/constants/values_manger.dart';
import 'package:kenz/models/pos_sales_model/payment_type_model.dart';
import 'package:kenz/models/pos_sales_model/sales_shift_model.dart';
import 'package:kenz/provider/product_management_notifier.dart';
import 'package:kenz/provider/setup_settings_notifier.dart';

import '../constants/string_manager.dart';
import '../core/notifier/checkinout.dart';
import '../core/service/shared_preferance_service.dart';
import '../models/pos_sales_model/sales_model.dart';
import '../models/pos_sales_model/sales_product_model.dart';
import 'checken_in_notifier.dart';
import 'customer_notifier.dart';
import 'dataBase_fetch_notifier.dart';
import 'database_functionalities_notifier.dart';

class PosSaleNotifier extends ChangeNotifier {


  List<PosSalesModel> _posSale = [];
  List<PosSalesModel> _posPostSale = [];

  CacheService _cashService = CacheService();

  List<PosSalesModel>?   get getRecentSales => _posSale;
  List<PosSalesModel>?   get getPostSales => _posPostSale;

  Future<String?> setPosSaleInvoice({required BuildContext context,required List<SalesProductModel>? listProductData}) async {
    try{
      final productManagementNotifier = context.read<ProductManagementNotifier>();
      final customerNotifier = context.read<CustomerNotifier>();
      final checkeninOut = context.read<CheckOutINIDNotifier>();
      final dbFuncNotifier = context.read<DataBaseFunctionalities>();
      final dbFetchNotifier = context.read<DataBaseFetchNotifier>();
      final userID = await _cashService.readCache(key: AppStrings.userId);

      final checkInNotifier = context.read<CheckInOutNotifier>();
      _posSale.add(PosSalesModel(
          balance: productManagementNotifier.getBalance.toString(),
          user_id: int.parse(userID),
          created: DateTime.now().toString(),
          discount_price: "0",
          given_amount: productManagementNotifier.getPaid.toString(),
          order_id: productManagementNotifier.getOrderNo.toString(),
          invoice_id: productManagementNotifier.getInvoiceNo.toString(),
          items:listProductData,
          is_parcel: productManagementNotifier.getIsParcel.toString(),
          multi:productManagementNotifier.getPaymentTypeString == "Multi" ? PaymentTypeModel(order: productManagementNotifier.getPaymentType.keys.first,
              credit:productManagementNotifier.getPaymentType[productManagementNotifier.getPaymentType.keys.first]?.credit,
              cash: productManagementNotifier.getPaymentType[productManagementNotifier.getPaymentType.keys.first]?.cash,
              card: productManagementNotifier.getPaymentType[productManagementNotifier.getPaymentType.keys.first]?.card
          ):null,
          sub_total: productManagementNotifier.getSubTotal.toStringAsFixed(2),
          total: productManagementNotifier.getTotal.toStringAsFixed(2),
          vat_total: productManagementNotifier.getTaxAmount.toStringAsFixed(2),
          vat_percentage:context.read<SetupSettingsNotifier>().getVatPercentage.toString(),
          shift: checkeninOut.getSeriesFetch ?? 0,
          customerName: customerNotifier.getCustomerName,
        payment_type: productManagementNotifier.getPaymentTypeString
      ));
      _posPostSale.add(PosSalesModel(
          balance: productManagementNotifier.getBalance.toString(),
          user_id: int.parse(userID),
          created: DateTime.now().toString(),
          discount_price: "0",
          given_amount: productManagementNotifier.getPaid.toString(),
          order_id: productManagementNotifier.getOrderNo.toString(),
          invoice_id: productManagementNotifier.getInvoiceNo.toString(),
          items:listProductData,
          is_parcel:productManagementNotifier.getIsParcel.toString(),
          multi:productManagementNotifier.getPaymentTypeString == "Multi" ? PaymentTypeModel(order: productManagementNotifier.getPaymentType.keys.first,
              credit:productManagementNotifier.getPaymentType[productManagementNotifier.getPaymentType.keys.first]?.credit,
              cash: productManagementNotifier.getPaymentType[productManagementNotifier.getPaymentType.keys.first]?.cash,
              card: productManagementNotifier.getPaymentType[productManagementNotifier.getPaymentType.keys.first]?.card
          ):null,
          sub_total: productManagementNotifier.getSubTotal.toStringAsFixed(2),
          total: productManagementNotifier.getTotal.toStringAsFixed(2),
          vat_total: productManagementNotifier.getTaxAmount.toStringAsFixed(2),
          vat_percentage:context.read<SetupSettingsNotifier>().getVatPercentage.toString(),
          shift: checkeninOut.getSeriesFetch ?? 0,
          customerName: customerNotifier.getCustomerName,
          payment_type: productManagementNotifier.getPaymentTypeString
      ));
      notifyListeners();
      print("lllllllllll2w ${_posSale.length} ");
      print("lllllllllll2ws ${_posPostSale.length} ");

      await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbPOSSalesInfo, dbData: _posSale);
      await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbPOSPostSalesInfo, dbData: _posPostSale);
      print("lllllllllll2");
      return "OK";
    }catch(e){
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return showAwesomeDialogue(title: "Error", content: "Please try again later $e",);

        },
      );
    }
    return null;

  }


  Future<String?> retrieveResentInvoice({required BuildContext context}) async {
    try{
      final dbFetchNotifier = context.read<DataBaseFetchNotifier>();
      await dbFetchNotifier.fetchPosResendSalesModel(context: context);
      final dataList =dbFetchNotifier.getPosResendSalesModel ?? [];
      _posSale = dataList.cast();
      notifyListeners();
      return "OK";
    }catch(e){
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return showAwesomeDialogue(title: "Error", content: "Please try again later $e",);

        },
      );
    }
    return null;

  }

  Future<String?> retrievePostInvoice({required BuildContext context}) async {
    try{
      final dbFetchNotifier = context.read<DataBaseFetchNotifier>();
      await dbFetchNotifier.fetchPosPostSalesModel(context: context);
      final dataList =dbFetchNotifier.getPosPostSalesModel ?? [];
      print("qwe ${dataList.length}");
      _posPostSale = dataList.cast();
      notifyListeners();
      return "OK";
    }catch(e){
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return showAwesomeDialogue(title: "Error", content: "Please try again later $e",);

        },
      );
    }
    return null;

  }


}