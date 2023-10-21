//
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:kenz_app/main.dart';
// import 'package:provider/provider.dart';
//
// import '../constants/color_manger.dart';
// import '../constants/constants.dart';
// import '../constants/style_manager.dart';
// import '../models/barcode_model/product_list_model.dart';
// import '../models/product_model/product_data_list_model.dart';
// import '../models/uom_model/uom_data_list_model.dart';
// import 'dataBase_fetch_notifier.dart';
//
// class SearchNotifier extends ChangeNotifier{
//
//   String? _name,_barcode,_uom,_scannedUom,_productCode;
//   List<UOMDataListModel>? _measurement =[];
//   String? get getBarcode => _barcode;
//   String? get getName => _name;
//   String? get getUOM => _uom;
//   String? get getScannedUOM => _scannedUom;
//   String? get getProductCode => _productCode;
//   List<UOMDataListModel>? get getMeasurements => _measurement;
//
//   void clearVariables(){
//     _name = null;
//     _barcode = null;
//     _uom = null;
//     _scannedUom = null;
//     _productCode = null;
//     _measurement = [];
//     notifyListeners();
//   }
//
//   List<ProductDataListModel>? _fetchedProductsList;
//   List<UOMDataListModel>? _fetchedUOMList;
//   List<BarcodeDataListModel>? _fetchedBarcodeList;
//   List<ProductDataListModel>? get getFetchedProductList => _fetchedProductsList;
//   List<UOMDataListModel>? get getFetchedUOMList => _fetchedUOMList;
//   List<BarcodeDataListModel>? get getFetchedBarcodeList =>_fetchedBarcodeList;
//
//
//   Map<String,ProductDataListModel>?    _processedListProducts;
//   Map<String,List<UOMDataListModel>>?     _processedListUOM;
//   Map<String,BarcodeDataListModel>?   _processedListBarcode;
//   Map<String,List<BarcodeDataListModel>>?  _processedListBarcodeProduct;
//
//   Map<String,ProductDataListModel>? get getFetchedProductsMap =>_processedListProducts;
//   Map<String,List<UOMDataListModel>>? get getFetchedUOMMap => _processedListUOM;
//   Map<String,BarcodeDataListModel>? get getFetchedBarcodeMap => _processedListBarcode;
//
//   void clearSearchNotifier(){
//     clearVariables();
//     // _fetchedProductsList = null;
//     // _fetchedUOMList = null;
//     // _fetchedBarcodeList = null;
//     // _processedListProducts = null;
//     // _processedListUOM = null;
//     // _processedListBarcode = null;
//     // _processedListBarcodeProduct=null;
//     notifyListeners();
//   }
//
//
//
//   Future<void> initializeVariables({required BuildContext context}) async {
//     try{
//       final pullNotifier = context.read<DataBaseFetchNotifier>();
//       await pullNotifier.fetchBarcodes(context: context);
//       await pullNotifier.fetchProducts(context: context);
//       await pullNotifier.fetchUOM(context: context);
//       _fetchedBarcodeList=[];
//       _fetchedProductsList=[];
//       _fetchedUOMList=[];
//       _fetchedBarcodeList = pullNotifier.getFetchedBarcode?.Entities ?? [];
//       _fetchedProductsList = pullNotifier.getFetchedProducts?.Entities ?? [];
//       _fetchedUOMList = pullNotifier.getFetchedUOM?.Entities ?? [];
//       notifyListeners();
//     }catch(e){
//       showAwesomeDialogue(title: "Warning", content: "Please try again later, Could not post", type: DialogType.WARNING);
//
//     }
//
//   }
//
//   void setProcessedData({
//     required Map<String,ProductDataListModel> products,
//     required Map<String,List<UOMDataListModel>> uom,
//     required Map<String,BarcodeDataListModel> barcode, required  Map<String,List<BarcodeDataListModel>>  processedListBarcodeProduct
//   }){
//     _processedListProducts = products;
//     _processedListUOM = uom;
//     _processedListBarcode = barcode;
//     _processedListBarcodeProduct = processedListBarcodeProduct;
//     // _processedListUOM?.addAll({
//     //   "10000":[UOMDataListModel(ItemNo: "10000",QtyPerUnitOfMeasure: 100,Code: "CARTON"),UOMDataListModel(ItemNo: "10000",QtyPerUnitOfMeasure: 200,Code: "PACK 1")]
//     // });
//     notifyListeners();
//   }
//
//   Future<String?> searchBarcode({required String barcode}) async {
//     try{
//       _barcode = barcode;
//       _productCode = _processedListBarcode![barcode]!.ItemNo;
//       _scannedUom =_processedListBarcode![barcode]!.UnitOfMeasureCode;
//       print("lllll1 $_productCode $_scannedUom");
//       notifyListeners();
//       return await searchProductCode();
//
//
//     }catch(e){
//       showAwesomeDialogue(title: "Info", content: "Could find barcode in database\n Please try again", type: DialogType.INFO_REVERSED);
//        return 'NO';
//     }
//     return null;
//   }
//
//   Future<void> searchBarcodeUsingProduct({required BuildContext context ,required String productCode,required String uom}) async {
//     try{
//       print("ddddddddddddddd");
//       bool elementFound = false;
//
//        _processedListBarcodeProduct?[productCode]?.forEach((element) {
//           if(element.UnitOfMeasureCode == uom){
//             _barcode=element.BarcodeNo ?? "";
//             elementFound = true;
//             notifyListeners();
//           }
//        });
//    if(elementFound == false){
//      _barcode = null;
//      notifyListeners();
//      showSnackBar(context: context, text: "Could find barcode against product code ($productCode)");
//      // showAwesomeDialogue(title: "Info", content: "Could find barcode against product code ($productCode) and UOM ($uom) in database\n Please try again", type: DialogType.INFO_REVERSED);
//    }
//
//     }catch(e){
//       print("ddddddddddddddd $e");
//       showSnackBar(context: context, text: "Could find barcode against product code ($productCode) ");
//
//       // showAwesomeDialogue(title: "Info", content: "Could find barcode against product code ($productCode) and UOM ($uom) in database\n Please try again", type: DialogType.INFO_REVERSED);
//
//     }
//   }
//
//   Future<String?> searchProductCode({ String? productCode }) async {
//     try{
//
//       _name = _processedListProducts![productCode ?? _productCode]!.Description!;
//       _uom =_processedListProducts![productCode ??_productCode]!.BaseUnitOfMeasure!;
//       print("lllll2 $_name $_uom");
//       if(productCode!=null){
//         _productCode=productCode;
//         notifyListeners();
//       }
//       notifyListeners();
//       return await searchUOMCode();
//
//
//     }catch(e){
//       showAwesomeDialogue(title: "Info", content: "Could find product in database\n Please try again", type: DialogType.INFO_REVERSED);
//       return 'NO';
//
//       // Your AwesomeDialog code here
//     }
//     return null;
//   }
//
//   Future<String?> searchUOMCode() async {
//     try{
//       print("lllll3 $_scannedUom");
//       _measurement = _processedListUOM![_productCode];
//       print("lllll3 $_measurement");
//       return 'OK';
//
//       notifyListeners();
//     }catch(e){
//       showAwesomeDialogue(title: "Info", content: "Could find UOM for product ($_productCode) in database\n Please try again", type: DialogType.INFO_REVERSED);
//       return 'NO';
//
//       // Your AwesomeDialog code here
//     }
//     return null;
//   }
// }
//
