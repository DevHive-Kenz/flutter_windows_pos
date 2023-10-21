// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_manager.dart';
import '../../../../provider/general_notifier.dart';
import '../../../models/profile_model/profile_model.dart';
import '../../../provider/dataBase_fetch_notifier.dart';
import '../../../provider/database_functionalities_notifier.dart';
import '../../api/profile_api/profile_api.dart';
import '../../service/shared_preferance_service.dart';



class ProfileNotifier extends ChangeNotifier {
  final ProfileApi _profileApi = ProfileApi();

  bool _isLoading = false;
  int? _statusCode;
  ProfileModel? _profileModelData;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  ProfileModel? get getProfile => _profileModelData;


  Future<String?> profile({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      // final generalNotifier = context.read<GeneralNotifier>();
      final dbFuncNotifier = context.read<DataBaseFunctionalities>();
      final dbFetchNotifier = context.read<DataBaseFetchNotifier>();
      final generalNotifier = context.read<GeneralNotifier>();
      await generalNotifier.checkUserConnection();

      if(generalNotifier.getNetAvailableBool){
        final listData = await _profileApi.profile();

        if(listData["status"] == 200){
          _isLoading = false;
          _profileModelData = ProfileModel.fromJson(listData);
          await dbFuncNotifier.saveDataBase(dbName: AppStrings.dbProfileList, dbData: _profileModelData);

          notifyListeners();
          return "OK";
        }else{
          _isLoading = false;
          notifyListeners();
          showAwesomeDialogue(title: "Warning", content: "Please try again",);
        }
      }else{

        await dbFetchNotifier.fetchProfile( context:context);
        _profileModelData = dbFetchNotifier.getProfile ;
        print("checkkkiipr ${_profileModelData?.result?.length}");

        notifyListeners();

      }



      _isLoading = false;
      notifyListeners();
    } catch(error){
      print(error);

      showAwesomeDialogue(title: "Warning", content: "Please try again later",);
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}