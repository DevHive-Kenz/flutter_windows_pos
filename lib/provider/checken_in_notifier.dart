import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:kenz/constants/constants.dart';
import 'package:kenz/constants/string_manager.dart';
import 'package:kenz/core/service/shared_preferance_service.dart';
import 'package:kenz/screens/widget/Circular_progress_indicator_widget.dart';

import '../constants/color_manger.dart';
import '../constants/style_manager.dart';
import '../constants/values_manger.dart';
import '../core/notifier/checkinout.dart';
import '../models/check_in_model/check_in_model.dart';
import '../screens/widget/rounded_button_widget.dart';
import 'dataBase_fetch_notifier.dart';
import 'database_functionalities_notifier.dart';

class CheckInOutNotifier extends ChangeNotifier{

  CheckInModel? _isCheckIn;

  CheckInModel? get getIsCheckIn => _isCheckIn;
  CacheService _cacheService = CacheService();


 Future<void> setCheckIn({required bool checkIN, required BuildContext context}) async {
   final dbFuncNotifier = context.read<DataBaseFunctionalities>();
   final user = await _cacheService.readCache(key: AppStrings.userId);
   CheckInModel? _dataToStore;
   if(checkIN){
     _dataToStore = CheckInModel(isCheckIN: checkIN,checkIn: DateTime.now(),checkOut: null,user: user);
   }else{
     _dataToStore = CheckInModel(isCheckIN: checkIN,checkIn: _isCheckIn?.checkIn ,checkOut: DateTime.now(),user: user);
   }
   notifyListeners();
   await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbCheckIN, dbData: _dataToStore);
 }

  Future<void> retrieveCheckIn({ required BuildContext context}) async {
    final dbFuncNotifier = context.read<DataBaseFetchNotifier>();
    await dbFuncNotifier.fetchCheckInModel(context: context);

    _isCheckIn = dbFuncNotifier.getCheckIn;
    notifyListeners();
    print( "33333333333 ${_isCheckIn?.isCheckIN}");
    if(_isCheckIn?.isCheckIN == null || _isCheckIn?.isCheckIN== false){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, stateSetterSetModalState){
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(12.0),
              ),
              child: Container(
                width: 150.w,
                padding: EdgeInsets.all(AppPadding.p22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorManager.white,

                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min ,
                  children: [
                    Text("Welcome to the POS setup. It seems you haven't started your shift yet. It's essential to check in to ensure all sales are recorded correctly during your active hours.",style: getSemiBoldStyle(color: ColorManager.black,fontSize: AppSize.s16),),
                    kSizedBox20,
                    Align(
                      child: SizedBox(
                        width: 50.w,
                        child: Consumer<CheckOutINIDNotifier>(
                          builder: (context, snapshot,_) {
                            return snapshot.getIsLoading ? CircularProgressIndicatorWidget() : CustomButton(onTap: () async {
                              await snapshot.checkinOut(type: "checkin", context: context);
                              setCheckIn(checkIN: true, context: context);
                              Navigator.pop(context);
                            },
                              title: "Check in",
                              width: 35.w,
                            );
                          }
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });

        },
      );
    }
    notifyListeners();
  }
  
  

}