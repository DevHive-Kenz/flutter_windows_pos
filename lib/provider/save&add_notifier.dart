// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
//
// import '../constants/constants.dart';
// import '../constants/string_manager.dart';
// import '../models/save&add/save_and_add_list_model.dart';
// import '../models/save&add/save_and_add_model.dart';
// import 'dataBase_fetch_notifier.dart';
// import 'database_functionalities_notifier.dart';
//
// class SaveAndAddNotifier extends ChangeNotifier {
//   List<SaveAndAddListModel> _dataToAdd = [];
//   SaveAndAddModel? _dataToAddInMap;
//   bool _isLoading = false;
//
//   bool get getIsLoading => _isLoading;
//
//   void clear(){
//     _dataToAdd = [];
//     _dataToAddInMap=null;
//     notifyListeners();
//   }
//
//
//   Future<void> saveAndAdd({required BuildContext context,
//     required String barcode,
//     required String baseUnit,
//     required String desc,
//     required String itemNo,
//     required num phyQTY,
//     required String scannedQTY,
//     required String scannedUnit}) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//       final dbFetchNotifier = context.read<DataBaseFetchNotifier>();
//       final dbFuncNotifier = context.read<DataBaseFunctionalities>();
//
//       if (_dataToAdd.isEmpty) {
//         await dbFetchNotifier.fetchSaveAndAdd(context: context);
//         _dataToAdd = dbFetchNotifier.getFetchedSaveAndAdd?.Entities ?? [];
//         notifyListeners();
//       }
//       _dataToAdd.add(
//         SaveAndAddListModel(
//           Barcode: barcode,
//           BaseUnitOfMeasure: baseUnit,
//           Description: desc,
//           ItemNo: itemNo,
//           PhysQuantity: phyQTY,
//           ScannedQTY: scannedQTY,
//           ScannedUnit: scannedUnit,
//         ),
//       );
//       notifyListeners();
//       _dataToAddInMap = SaveAndAddModel(DeviceId: "", Entities: _dataToAdd);
//       if (_dataToAddInMap != null) {
//         await dbFuncNotifier.saveDataBase(
//             dbName: AppStrings.dbSaveAndAdd, dbData: _dataToAddInMap);
//       }else{
//         showAwesomeDialogue(title: "Warning", content: "Could not save data\nPlease Try again", type: DialogType.WARNING);
//       }
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       showAwesomeDialogue(title: "Error", content: "Please Try again later", type: DialogType.ERROR);
//
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }