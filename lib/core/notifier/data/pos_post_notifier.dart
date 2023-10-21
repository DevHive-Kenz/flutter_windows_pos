
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kenz/core/api/data/pos_post_api.dart';
import 'package:kenz/provider/dataBase_fetch_notifier.dart';

import '../../../constants/app_routes.dart';
import '../../../constants/constants.dart';
import '../../../constants/string_manager.dart';
import '../../../models/product_model/product_model.dart';
import '../../../provider/database_functionalities_notifier.dart';
import '../../../provider/general_notifier.dart';
import '../../../provider/pos_sales_notifier.dart';
import '../../api/auth/login_api.dart';
import '../../api/data/product_list_api.dart';
import '../../api/profile_api/profile_api.dart';
import '../../service/shared_preferance_service.dart';


class PosPostNotifier extends ChangeNotifier {

  final PostPosApi _posPostAPI = PostPosApi();
  bool _isLoading = false;

  ProductModel? _productData;

  bool get getIsLoading => _isLoading;

  ProductModel? get getProductData => _productData;



  Future<String?> getPostList({
    required BuildContext context,
  }) async {
    final dbFuncNotifier = context.read<DataBaseFunctionalities>();
    final dbFetchNotifier = context.read<DataBaseFetchNotifier>();
    final posSaleNotifier = context.read<PosSaleNotifier>();
    final generalNotifier = context.read<GeneralNotifier>();
    await generalNotifier.checkUserConnection();
    await posSaleNotifier.retrievePostInvoice(context: context);
    if(generalNotifier.getNetAvailableBool){
      try {
        _isLoading = true;
        notifyListeners();

        final listData = await _posPostAPI.postPosApi(data: posSaleNotifier.getPostSales);

        if(listData["status"] == 200 ||listData["status"] == 201){
         showAwesomeDialogue(content: "Successfully Posted Data");
         dbFuncNotifier.deleteDB(dbTable: AppStrings.dbPOSPostSalesInfo);
         _isLoading = false;
         notifyListeners();
         return "OK";
        }else{
          showDialog(
            context: context,
            builder: (context) {
              return showAwesomeDialogue(title: "Warning", content: listData["message"]);
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
      showAwesomeDialogue(content: "Please Connect to internet and try again");
      notifyListeners();
    }
    return null;
  }
}