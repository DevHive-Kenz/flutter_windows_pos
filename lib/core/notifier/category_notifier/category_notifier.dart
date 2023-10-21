// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_manager.dart';
import '../../../../provider/general_notifier.dart';
import '../../../models/category_model/category_model.dart';
import '../../../provider/dataBase_fetch_notifier.dart';
import '../../../provider/database_functionalities_notifier.dart';
import '../../api/data/category_api.dart';
import '../../service/shared_preferance_service.dart';



class CategoryNotifier extends ChangeNotifier {
  final CategoryPosApi _categoryApi = CategoryPosApi();

  bool _isLoading = false;
  int? _statusCode;
  CategoryModel? _categoryModelData;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  CategoryModel? get getCategory => _categoryModelData;


  Future<String?> category({
    required BuildContext context,
  }) async {
    try {
      final dbFuncNotifier = context.read<DataBaseFunctionalities>();
      final dbFetchNotifier = context.read<DataBaseFetchNotifier>();
      final generalNotifier = context.read<GeneralNotifier>();
      await generalNotifier.checkUserConnection();
      _isLoading = true;
      notifyListeners();

      if(generalNotifier.getNetAvailableBool){
        final listData = await _categoryApi.categoryPosApi();
        if(listData["status"] == 200||listData["status"] == 1){
          _categoryModelData = CategoryModel.fromJson(listData);
           await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbCategoryList, dbData: _categoryModelData);
          _isLoading = false;
           notifyListeners();
        }else{
          _isLoading = false;
          notifyListeners();
          showAwesomeDialogue(title: "Warning", content: "Please try againe",);
        }
      }else{
        print("checkkkii");
        await dbFetchNotifier.fetchCategory( context:context);
        print("checkkkii");

        _categoryModelData = dbFetchNotifier.getCategory ;
        print("checkkkii ${_categoryModelData?.result?.length}");

        notifyListeners();
      }
      // final generalNotifier = context.read<GeneralNotifier>();



      _isLoading = false;
      notifyListeners();
    } catch(error){
      print(error);

      showAwesomeDialogue(title: "Warning", content: "Please try again later", );
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}