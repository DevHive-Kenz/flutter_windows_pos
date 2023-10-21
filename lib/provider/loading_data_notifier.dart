// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:kenz_app/provider/dataBase_fetch_notifier.dart';
// import 'package:kenz_app/provider/search_notifier.dart';
// import 'package:provider/provider.dart';
//
// import '../constants/app_routes.dart';
// import '../constants/constants.dart';
// import 'isolate_notifier.dart';
//
// class LoadingDataNotifier extends ChangeNotifier{
// bool _isLoading =false;
//
// bool get getIsLoading => _isLoading;
//   Future<void> callingFunctions({required BuildContext context}) async {
//     try{
//       _isLoading = true;
//       notifyListeners();
//       final searchNotifier = context.read<SearchNotifier>();
//       await searchNotifier.initializeVariables(context: context).then((value) async {
//         if((searchNotifier.getFetchedBarcodeList?.isNotEmpty ?? false) && searchNotifier.getFetchedBarcodeList !=null) {
//           await HeavyTask().useIsolate(barcodeList: searchNotifier.getFetchedBarcodeList ?? [], productList: searchNotifier.getFetchedProductList ?? [], uomList: searchNotifier.getFetchedUOMList ?? [],).then((value) async {
//           searchNotifier.setProcessedData(barcode: value[0],products: value[1], uom: value[2],processedListBarcodeProduct: value[3]);
//           Navigator.pushNamed(context, stockTakeScreen);
//
//         });
//         }else{
//           showAwesomeDialogue(title: "Info", content: "Please Get Products before Continuing", type: DialogType.INFO_REVERSED);
//
//         }
//       });
//       _isLoading = false;
//       notifyListeners();
//     }catch(e){
//       showAwesomeDialogue(title: "Error", content: "Could not fetch data\nPlease try again later", type: DialogType.ERROR);
//
//       print(e);
//       _isLoading = false;
//       notifyListeners();
//     }
//
//   }
//
// }