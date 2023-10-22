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
import '../core/service/shared_preferance_service.dart';
import '../models/pos_sales_model/sales_model.dart';
import '../models/pos_sales_model/sales_product_model.dart';
import 'checken_in_notifier.dart';
import 'customer_notifier.dart';
import 'dataBase_fetch_notifier.dart';
import 'database_functionalities_notifier.dart';

class DraftNotifier extends ChangeNotifier {

  int _draftNumber= 1;
  List<dynamic> _draftSales = [];

  CacheService _cashService = CacheService();

  int get getInvoiceNo => _draftNumber;
  List<dynamic>?   get getDraftSales => _draftSales;

  Future<String?> setDraftInvoice({required BuildContext context}) async {
    try{
      final productManagementNotifier = context.read<ProductManagementNotifier>();
      final customerNotifier = context.read<CustomerNotifier>();
      final dbFuncNotifier = context.read<DataBaseFunctionalities>();

      final userID = await _cashService.readCache(key: AppStrings.userId);
      List<SalesProductModel> listProductData = [];
      productManagementNotifier.getSelectedIndices.forEach((data) {
        print("lllllllll ${data.qty?.toStringAsFixed(2)}");
        listProductData.add(SalesProductModel(
            name: data.name,
            name_arabic: data.name_arabic,
            discount: "0.00",
            discount_type: "fixed",
            discounted_price: "0.00",
            gross_total: data.priceWithoutVat?.toStringAsFixed(2),
            quantity:  data.qty.toString(),
            total_amount:data.total?.toStringAsFixed(2),
            vat_amount: data.vat?.toStringAsFixed(2),
          product_id: data.id.toString()
        ));
      });


      /// Draft entry
      _draftSales.add(PosSalesModel(
        user_id: int.parse(userID),
        created: DateTime.now().toString(),
        discount_price: "0",
        given_amount: productManagementNotifier.getPaid.toString(),
        order_id: productManagementNotifier.getOrderNo.toString(),
        invoice_id:_draftNumber.toString(),
        items: listProductData,
        is_parcel: null,
        sub_total: productManagementNotifier.getSubTotal.toString(),
        total: productManagementNotifier.getTotal.toString(),
        vat_total: productManagementNotifier.getTaxAmount.toString(),
        vat_percentage: context.read<SetupSettingsNotifier>().getVatPercentage.toString(),
        customerName: customerNotifier.getCustomerName
      ));
      await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbPOSDraftInfo, dbData: _draftSales).then((value) async {
        await setDraftID(context: context);
      });

      productManagementNotifier.cleanAfterSale();
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

  Future<void> setDraftID({required BuildContext context}) async {
    final dbFuncNotifier = context.read<DataBaseFunctionalities>();
    _draftNumber = _draftNumber +1;
    notifyListeners();
    await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbDraftID, dbData: _draftNumber);
  }

  Future<void> retrieveDraftID({required BuildContext context}) async {
    final dbFuncNotifier = context.read<DataBaseFetchNotifier>();
    await dbFuncNotifier.fetchDraftID(context: context);
    await dbFuncNotifier.fetchInvoiceID(context: context);
    _draftNumber = dbFuncNotifier.getInvoiceNumber ?? 1;
    //todo:API: retrive order ID and invoice number from api
    notifyListeners();
  }

  Future<String?> retrieveDraftInvoice({required BuildContext context}) async {
    try{

      final dbFetchNotifier = context.read<DataBaseFetchNotifier>();
      await dbFetchNotifier.fetchPosDraftModel(context: context);
      _draftSales = dbFetchNotifier.getPosDraftModel ?? [];
      notifyListeners();
      return "OK";
    }catch(e){
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