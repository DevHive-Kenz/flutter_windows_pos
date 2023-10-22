import 'dart:async';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kenz/constants/constants.dart';
import 'package:kenz/main.dart';
import 'package:kenz/provider/setup_settings_notifier.dart';


import '../constants/api_const/api_const.dart';
import '../constants/string_manager.dart';
import '../core/service/shared_preferance_service.dart';
import '../models/pos_sales_model/payment_type_model.dart';
import '../models/product_model/product_content_model.dart';
import 'dataBase_fetch_notifier.dart';
import 'database_functionalities_notifier.dart';


enum PaymentType {CASH,CARD,CREDIT,MULTI,EXPRESS,NONE}

class ProductManagementNotifier extends ChangeNotifier {

  bool _updateDisabled = true;
  double _subTotal = 0.00;
  double _taxAmount= 0.00;
  double _total=0.00;
  double _paid=0.00;
  double _balance=0.00;
  int _orderNumber= 1;
  int _invoiceNumber= 1;
  String _invoicePrefix= "INV";
  bool _isParcel= false;
  Map<String,PaymentTypeModel> _paymentType ={};
  String? _paymentTypeString;
List<PaymentTypeModel>? _multiModelList;
List<PaymentTypeModel>? get getMultiModelList =>_multiModelList;
  List<ProductContentModel> _selectedProducts = [];

  CacheService cashService = CacheService();


  bool get getUpdateDisabledBool => _updateDisabled;
  bool get getIsParcel => _isParcel;
  double get getSubTotal => _subTotal;
  double get getPaid => _paid;
  double get getBalance => _balance;
  double get getTaxAmount => _taxAmount;
  double get getTotal => _total;
  int get getOrderNo => _orderNumber;
  int get getInvoiceNo => _invoiceNumber;
  String get getInvoicePrefix => _invoicePrefix;
  String? get getPaymentTypeString => _paymentTypeString;
  List<ProductContentModel> get getSelectedIndices => _selectedProducts;
  Map<String,PaymentTypeModel> get getPaymentType => _paymentType;



  void cleanAfterSale(){
    _selectedProducts = [];
    _subTotal = 0.00;
    _taxAmount= 0.00;
    _total=0.00;
    _balance=0.00;
    _paid=0.00;
    _paymentType = {};
    notifyListeners();
  }

  void isParcel (bool value){
    _isParcel = value;
    notifyListeners();
  }

  void setPaymentTypeString (String value){
    _paymentTypeString = value;
    notifyListeners();
  }

  void productSummaryManagement(
      {required ProductContentModel product,required bool isDelete,required BuildContext context,required bool isDraftConverting}) {

    _updateDisabled = true;
    if (_selectedProducts.contains(product)) {
      int index = _selectedProducts.indexOf(product);

      if(isDelete){
        _selectedProducts[index].qty = (_selectedProducts[index].qty ?? 0) > 0 ?( _selectedProducts[index].qty ??0) - 1:0;
        if((_selectedProducts[index].qty ?? 0) <= 0){
          _selectedProducts.removeAt(index);
        }
      }else{
        _selectedProducts[index].qty =(_selectedProducts[index].qty ??0) + 1;
        _selectedProducts[index].total = double.parse(((_selectedProducts[index].qty ?? 0) * (_selectedProducts[index].price ?? 0)).toStringAsFixed(2));
      }

    } else {
      // If the product is not in the selected list, add it with a quantity of 1
      if(isDraftConverting==false){
        product.qty = 1;
      }
      // product.priceWithoutVat = ((product.price ?? 0) / (1 + _vatPercentage / 100));
      product.priceWithoutVat = (product.price ?? 0) /(100 + context.read<SetupSettingsNotifier>().getVatPercentage) *100;
      product.vat = (product.price ?? 0) - (product.priceWithoutVat ?? 0);
      _selectedProducts.add(product);
    }
    productCalculation(product: product);
    notifyListeners();
  }

  void deleteProductFromSummary(ProductContentModel product) {
    _updateDisabled = true;

    if (_selectedProducts.contains(product)) {
      int index = _selectedProducts.indexOf(product);
      _selectedProducts[index].qty =0;
      _selectedProducts.removeAt(index);
    } else {
      // If the product is not in the selected list, add it with a quantity of 1
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return       showAwesomeDialogue(content: "Product Not Available",title: "Warning");

        },
      );
    }
    productCalculation(product: product);
    notifyListeners();
  }

  void editProductFromSummary(ProductContentModel product,String qty) {
    _updateDisabled = false;
    notifyListeners();
    if (_selectedProducts.contains(product)) {
      int index = _selectedProducts.indexOf(product);
      _selectedProducts[index].qty =int.parse(qty);
      if((_selectedProducts[index].qty ?? 0) <= 0){
        _selectedProducts.removeAt(index);
      }
    } else {
      // If the product is not in the selected list, add it with a quantity of 1
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return showAwesomeDialogue(content: "Product Not Available",title: "Warning");

        },
      );

    }
    productCalculation(product:product );

    notifyListeners();
  }

  bool isSelected(ProductContentModel product) {
    return _selectedProducts.contains(product);
  }



  void productCalculation({required ProductContentModel product}){
    int index = _selectedProducts.indexOf(product);
    if(index != -1){
      if(_selectedProducts[index].discounted_price != null ||_selectedProducts[index].discounted_price!= 0 ) {
        _selectedProducts[index].total = double.parse(((_selectedProducts[index].qty ?? 0) * (_selectedProducts[index].price ?? 0)).toStringAsFixed(2));
      }else{
        _selectedProducts[index].total = double.parse(((_selectedProducts[index].qty ?? 0) * (_selectedProducts[index].discounted_price ?? 0)).toStringAsFixed(2));
      }
    }

    _subTotal=0;
    _taxAmount=0;
    _total=0;
    _selectedProducts.forEach((element) {
     _subTotal = double.parse((_subTotal + ((element.priceWithoutVat ?? 0) * (element.qty ?? 0))).toStringAsFixed(2));
     _taxAmount = double.parse(( _taxAmount + ((element.vat ?? 0) * (element.qty ?? 0))).toStringAsFixed(2));
     _total = _subTotal + _taxAmount;
    });
    notifyListeners();
  }

  String? _cash;
  String? _card;
  String? _credit;

  void setPaymentType({required bool clean,required PaymentType type,required String? cardPrice,required String? creditPrice,required String? cashPrice}){
   if(clean){
     _credit = "0";
     _cash = "0";
     _card = "0";
     notifyListeners();
   }

    if(type == PaymentType.MULTI){
      if(cashPrice != null && cashPrice.isNotEmpty){
        _cash = cashPrice;
      }else if (cardPrice != null && cardPrice.isNotEmpty){
        _card = cardPrice;
      }else if (creditPrice != null && creditPrice.isNotEmpty){
        _credit = creditPrice;
      }
     _multiModelList =[
       PaymentTypeModel(paymentMethod: "Card",amount:_card ),
       PaymentTypeModel(paymentMethod: "Cash",amount:_cash ),
       PaymentTypeModel(paymentMethod: "Credit",amount:_credit ),
     ];
     notifyListeners();
    }
         //     String methodType = type == PaymentType.CARD ? "Card":type == PaymentType.CASH ? "Cash" :type == PaymentType.CREDIT ? "Credit" :"None";
         //     String payType = type == PaymentType.CARD ? "Card":type == PaymentType.CASH ? "Cash" :type == PaymentType.CREDIT ? "Credit" :type == PaymentType.MULTI ?"Multi":type == PaymentType.EXPRESS ?"Express":"None";
         //     _paymentType.update(payType, (value) => PaymentTypeModel(
         //     order: methodType,
         //     card: methodType == PaymentType.CARD ?price:"0.00",
         //     cash: methodType == PaymentType.CASH ?price:"0.00",
         //     credit: methodType == PaymentType.CREDIT ?price:"0.00"
         // ),ifAbsent: () => PaymentTypeModel(
         //     order: methodType,
         //     card: methodType == PaymentType.CARD ?price:"0.00",
         //     cash: methodType == PaymentType.CASH ?price:"0.00",
         //     credit: methodType == PaymentType.CREDIT ?price:"0.00"
         // ));
         //   notifyListeners();

  }


  Future<void> preSetInvoiceId({required BuildContext context, required int invoiceNumber, required String prefix}) async {
    final dbFuncNotifier = context.read<DataBaseFunctionalities>();

    _invoicePrefix = prefix;
    _invoiceNumber = invoiceNumber;
    notifyListeners();
    await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbInvoicePrefix, dbData: _invoicePrefix);
    await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbInvoiceID, dbData: _invoiceNumber);
  }

  Future<void> setOrderID({required BuildContext context,required int orderId}) async {
    final dbFuncNotifier = context.read<DataBaseFunctionalities>();
    _orderNumber = orderId;
    print("00000000000000000001");

    notifyListeners();
    print("00000000000000000002");

    await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbOrderID, dbData: _orderNumber);
    print("00000000000000000003 $_orderNumber");

    await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbInvoiceID, dbData: _invoiceNumber);
   await retrieveOrderAndInvoiceID(context: context);
    print("00000000000000000003 $_orderNumber");

  }

  Future<void> setOrderAndInvoiceID({required BuildContext context}) async {
    final dbFuncNotifier = context.read<DataBaseFunctionalities>();
    _orderNumber = _orderNumber +1;
    _invoiceNumber = _invoiceNumber +1;
    notifyListeners();
    await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbOrderID, dbData: _orderNumber);
    await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbInvoiceID, dbData: _invoiceNumber);
  }

  Future<void> retrieveOrderAndInvoiceID({required BuildContext context}) async {
    final dbFuncNotifier = context.read<DataBaseFetchNotifier>();
    await dbFuncNotifier.fetchOrderID(context: context);
    await dbFuncNotifier.fetchInvoiceID(context: context);
    await dbFuncNotifier.fetchInvoicePrefix(context: context);
    _orderNumber =  dbFuncNotifier.getOrderID ?? 1;
    _invoiceNumber = dbFuncNotifier.getInvoiceNumber ?? 1;
    _invoicePrefix = dbFuncNotifier.getInvoicePrefix ?? "INV";
    //todo:API: retrive order ID and invoice number from api
    notifyListeners();
  }

  void setCashAndBalance({required double cash, required double balance}){
    _balance = balance;
    _paid = cash;
    notifyListeners();
  }
}
