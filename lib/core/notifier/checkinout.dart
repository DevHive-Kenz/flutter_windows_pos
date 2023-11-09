import 'package:flutter/material.dart';
import 'package:kenz/constants/app_routes.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../provider/general_notifier.dart';
import '../../../provider/product_management_notifier.dart';
import '../../constants/string_manager.dart';
import '../../provider/checken_in_notifier.dart';
import '../../provider/dataBase_fetch_notifier.dart';
import '../../provider/database_functionalities_notifier.dart';
import '../api/checkout_api.dart';
import 'data/pos_post_notifier.dart';



class CheckOutINIDNotifier extends ChangeNotifier {
  final CheckINOUTAPI _checkINOUTAPI = CheckINOUTAPI();

  bool _isLoading = false;
  int? _statusCode;
  int? _checkInId;


  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  int? get getSeriesFetch => _checkInId;




  Future<String?> checkinOut({
    required BuildContext context,
    required String type,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      final dbFuncNotifier = context.read<DataBaseFunctionalities>();
      final generalNotifier = context.read<GeneralNotifier>();
      final checkInOutNotifier = context.read<CheckInOutNotifier>();


      if(generalNotifier.getNetAvailableBool){
        final listData = await _checkINOUTAPI.checkINOUTAPI(data: type);

        if(listData["status"] == 200 || listData["status"] == 201){
          _checkInId= (listData["result"] is int ) ? listData["result"]:0000000 ;
          await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbCheckInID, dbData: _checkInId);
         await context.read<ProductManagementNotifier>().setOrderID(context: context, orderId: 1);
          _isLoading = false;
          notifyListeners();
          return "OK";
        }else{
          _isLoading = false;
          notifyListeners();
          await context.read<PosPostNotifier>().getPostList(context: context).then((value) async {
            if(value =="OK"){
              await _checkINOUTAPI.checkINOUTAPI(data: "checkout").then((value) async {
                  await checkInOutNotifier.setCheckIn(checkIN: false, context: context);
                  Navigator.pushReplacementNamed(context, loginRoute);
              });

            }
          });
          showDialog(
            context: context,
            builder: (context) {
              return           showAwesomeDialogue(content: "Please Try Again Later (401)",title: "Warning");

            },
          );
          showAwesomeDialogue(title: "Warning", content: "Please try again", );
        }
      }else{
        showAwesomeDialogue(content: "Please Connect to internet",title: "Warning");
      }


      _isLoading = false;
      notifyListeners();
    } catch(error){
      showAwesomeDialogue(title: "Warning", content: "Please try again later",);
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<void> retrieveCheckInID({required BuildContext context}) async {
    final dbFuncNotifier = context.read<DataBaseFetchNotifier>();
    await dbFuncNotifier.fetchCheckInID(context: context);
    _checkInId = dbFuncNotifier.getCheckInId ;
    //todo:API: retrive order ID and invoice number from api
    notifyListeners();
  }
}