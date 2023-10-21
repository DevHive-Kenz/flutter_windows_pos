// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:provider/provider.dart';

import '../constants/constants.dart';

import '../constants/string_manager.dart';
import '../models/category_model/category_model.dart';
import '../models/pos_sales_model/sales_model.dart';
import '../models/product_model/product_model.dart';
import '../models/check_in_model/check_in_model.dart';
import '../models/profile_model/profile_model.dart';
import 'database_functionalities_notifier.dart';
class DataBaseFetchNotifier extends ChangeNotifier {

  ProductModel? _fetchedProduct;
  CategoryModel? _fetchedCategory;
  ProfileModel? _fetchedProfile;
  int? _orderID;
  int? _checkInID;
  int? _invoiceNumber;
  int? _draftNumber;
  CheckInModel? _checkIn;
  List<dynamic>? _posResentSalesModel;
  List<dynamic>? _posPostSalesModel;
  List<dynamic>? _posDraftModel;
  String? _invoicePrefix;


  String? get getInvoicePrefix => _invoicePrefix;
  CategoryModel? get getCategory =>_fetchedCategory;
  ProfileModel? get getProfile => _fetchedProfile;

  int? get getOrderID => _orderID;
  int? get getCheckInId => _checkInID;
  int? get getInvoiceNumber => _invoiceNumber;
  int? get getDraftNumber => _draftNumber;
  ProductModel? get getFetchedProducts => _fetchedProduct;
  List<dynamic>? get getPosResendSalesModel => _posResentSalesModel;
  List<dynamic>? get getPosPostSalesModel => _posPostSalesModel;
  List<dynamic>? get getPosDraftModel => _posDraftModel;
  CheckInModel? get getCheckIn => _checkIn;



  void clearDatabaseFetch(){

  notifyListeners();
}


  Future<void> fetchProfile ({required BuildContext context}) async {
    try {
      final dbNotifier = context.read<DataBaseFunctionalities>();
      await dbNotifier.fetchDatabase(dbName: AppStrings.dbProfileList);
      final data = dbNotifier.getFetchedData;
      _fetchedProfile = data;
      notifyListeners();
    }catch(e){
      showDialog(
        context: context,
        builder: (context) {
          return       showAwesomeDialogue(title: "Error", content: "Please try again later",);
        },
      );
    }
  }
  ///-------------------------------------------------------------------------------------------///

  Future<void> fetchCategory ({required BuildContext context}) async {
    try {
      final dbNotifier = context.read<DataBaseFunctionalities>();
      await dbNotifier.fetchDatabase(dbName: AppStrings.dbCategoryList);
      final data = dbNotifier.getFetchedData;
      _fetchedCategory = data;
      notifyListeners();
    }catch(e){
      showDialog(
        context: context,
        builder: (context) {
          return       showAwesomeDialogue(title: "Error", content: "Please try again later",);
        },
      );
    }
  }
  ///-------------------------------------------------------------------------------------------///
  Future<void> fetchProducts ({required BuildContext context}) async {
  try {
    final dbNotifier = context.read<DataBaseFunctionalities>();
    await dbNotifier.fetchDatabase(dbName: AppStrings.dbProduct);
    final data = dbNotifier.getFetchedData;
    _fetchedProduct = data;
    notifyListeners();
  }catch(e){

    showDialog(
      context: context,
      builder: (context) {
        return       showAwesomeDialogue(title: "Error", content: "Please try again later",);

      },
    );
  }
  }
///-------------------------------------------------------------------------------------------///
  Future<void> fetchOrderID ({required BuildContext context}) async {
    try {
      final dbNotifier = context.read<DataBaseFunctionalities>();
      await dbNotifier.fetchDatabase(dbName: AppStrings.dbOrderID);
      final data = dbNotifier.getFetchedData;
      _orderID = data;
      notifyListeners();
    }catch(e){
      showDialog(
        context: context,
        builder: (context) {
          return       showAwesomeDialogue(title: "Error", content: "Please try again later",);

        },
      );
    }
  }
  ///-------------------------------------------------------------------------------------------///
  Future<void> fetchCheckInID ({required BuildContext context}) async {
    try {
      final dbNotifier = context.read<DataBaseFunctionalities>();
      await dbNotifier.fetchDatabase(dbName: AppStrings.dbCheckInID);
      final data = dbNotifier.getFetchedData;
      _checkInID = data;
      notifyListeners();
    }catch(e){
      showDialog(
        context: context,
        builder: (context) {
          return       showAwesomeDialogue(title: "Error", content: "Please try again later$e",);

        },
      );
    }
  }
  ///-------------------------------------------------------------------------------------------///

  Future<void> fetchInvoiceID ({required BuildContext context}) async {
    try {
      final dbNotifier = context.read<DataBaseFunctionalities>();
      await dbNotifier.fetchDatabase(dbName: AppStrings.dbInvoiceID);
      final data = dbNotifier.getFetchedData;
      _invoiceNumber = data;
      notifyListeners();
    }catch(e){
      showDialog(
        context: context,
        builder: (context) {
          return       showAwesomeDialogue(title: "Error", content: "Please try again later",);

        },
      );
    }
  }
  ///-------------------------------------------------------------------------------------------///



  Future<void> fetchCheckInModel ({required BuildContext context}) async {
    try {
      final dbNotifier = context.read<DataBaseFunctionalities>();
      await dbNotifier.fetchDatabase(dbName: AppStrings.dbCheckIN);
      final data = dbNotifier.getFetchedData;
      _checkIn = data;
      notifyListeners();
    }catch(e){
      showDialog(
        context: context,
        builder: (context) {
          return       showAwesomeDialogue(title: "Error", content: "Please try again later",);

        },
      );
    }
  }
  ///-------------------------------------------------------------------------------------------///
  Future<void> fetchPosPostSalesModel ({required BuildContext context}) async {
    try {
      final dbNotifier = context.read<DataBaseFunctionalities>();
      await dbNotifier.fetchDatabase(dbName: AppStrings.dbPOSPostSalesInfo);
      final data = dbNotifier.getFetchedData;
      _posPostSalesModel = data;
      notifyListeners();
    }catch(e){
      showDialog(
        context: context,
        builder: (context) {
          return  showAwesomeDialogue(title: "Error", content: "Please try again later",);
        },
      );
    }
  }
///-------------------------------------------------------------------------------------------///
  Future<void> fetchPosResendSalesModel ({required BuildContext context}) async {
    try {
      final dbNotifier = context.read<DataBaseFunctionalities>();
      await dbNotifier.fetchDatabase(dbName: AppStrings.dbPOSSalesInfo);
      final data = dbNotifier.getFetchedData;
      _posResentSalesModel = data;
      notifyListeners();
    }catch(e){
      showDialog(
        context: context,
        builder: (context) {
          return  showAwesomeDialogue(title: "Error", content: "Please try again later",);
        },
      );
    }
  }

  ///-------------------------------------------------------------------------------------------///
  Future<void> fetchDraftID ({required BuildContext context}) async {
    try {
      final dbNotifier = context.read<DataBaseFunctionalities>();
      await dbNotifier.fetchDatabase(dbName: AppStrings.dbDraftID);
      final data = dbNotifier.getFetchedData;
      _draftNumber = data;
      notifyListeners();
    }catch(e){
      showDialog(
        context: context,
        builder: (context) {
          return showAwesomeDialogue(title: "Error", content: "Please try again later",);

        },
      );
    }
  }

  ///-------------------------------------------------------------------------------------------///

  Future<void> fetchPosDraftModel ({required BuildContext context}) async {
    try {
      final dbNotifier = context.read<DataBaseFunctionalities>();
      await dbNotifier.fetchDatabase(dbName: AppStrings.dbPOSDraftInfo);
      final data = dbNotifier.getFetchedData;
      print("333333333 $data");
      _posDraftModel = data;
      notifyListeners();
    }catch(e){
      showDialog(
        context: context,
        builder: (context) {
          return  showAwesomeDialogue(title: "Error", content: "Please try again later$e",);
        },
      );
    }
  }

  Future<void> fetchInvoicePrefix ({required BuildContext context}) async {
    try {
      final dbNotifier = context.read<DataBaseFunctionalities>();
      await dbNotifier.fetchDatabase(dbName: AppStrings.dbInvoicePrefix);
      final data = dbNotifier.getFetchedData;
      _invoicePrefix = data;
      notifyListeners();
    }catch(e){
      showDialog(
        context: context,
        builder: (context) {
          return       showAwesomeDialogue(title: "Error", content: "Please try again later",);

        },
      );
    }
  }



}