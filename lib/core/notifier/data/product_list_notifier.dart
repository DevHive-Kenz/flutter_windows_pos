
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kenz/provider/dataBase_fetch_notifier.dart';

import '../../../constants/app_routes.dart';
import '../../../constants/constants.dart';
import '../../../constants/string_manager.dart';
import '../../../models/product_model/product_content_model.dart';
import '../../../models/product_model/product_model.dart';
import '../../../provider/database_functionalities_notifier.dart';
import '../../../provider/general_notifier.dart';
import '../../api/auth/login_api.dart';
import '../../api/data/product_list_api.dart';
import '../../api/profile_api/profile_api.dart';
import '../../service/shared_preferance_service.dart';


class ProductListNotifier extends ChangeNotifier {

  final ProductListApi _productListApi = ProductListApi();
  bool _isLoading = false;
  int? _idSelectedCategory ;

  ProductModel? _productData;
  List<ProductContentModel> _productDataList =[];

  bool get getIsLoading => _isLoading;

  ProductModel? get getProductData => _productData;
  List<ProductContentModel>? get getProductListData => _productDataList;

  int?get  getSelectedCategory => _idSelectedCategory ;


  void search({required int id, required bool accessAll}){
    _productDataList = [];
    _idSelectedCategory = id;
    notifyListeners();
    print("sssssss");
    _productData?.result?.processedListProducts?.forEach((key, value) {
      if(value.category_id == id || accessAll){
        _productDataList.add(value);
      }
    });
    print("sssssss ${_productDataList.length}");

    notifyListeners();
  }


  Future<void> getProductList({
    required BuildContext context,
  }) async {
    final dbFuncNotifier = context.read<DataBaseFunctionalities>();
    final dbFetchNotifier = context.read<DataBaseFetchNotifier>();
    final generalNotifier = context.read<GeneralNotifier>();
   await generalNotifier.checkUserConnection();

    if(generalNotifier.getNetAvailableBool){
      try {
        _isLoading = true;
        notifyListeners();


        if(false){

        }
        final listData = await _productListApi.productListApi();

        if(listData["status"] == 200){
          _productData = ProductModel.fromJson(listData);
          notifyListeners();
          await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbProduct, dbData: _productData).then((value) async {
            generalNotifier.setPercent(66);
          });
          search(accessAll: true,id: 0000000);
          _isLoading = false;
          notifyListeners();
        }else{
          showDialog(
            context: context,
            builder: (context) {
              return            showAwesomeDialogue(title: "Warning", content: listData["message"]);
            },
          );


        }
        _isLoading = false;
        notifyListeners();
      } catch(error){

        showDialog(
          context: context,
          builder: (context) {
            return        showAwesomeDialogue(title: "Error", content: "Please try again later");

          },
        );
        print("eroor $error");
        _isLoading = false;
        notifyListeners();
      }
    }else{
     await dbFetchNotifier.fetchProducts( context:context);
     _productData = dbFetchNotifier.getFetchedProducts ;
     notifyListeners();
     search(accessAll: true,id: 0000000);
    }
  }
}