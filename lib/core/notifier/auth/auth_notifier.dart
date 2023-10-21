// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_routes.dart';
import '../../../constants/constants.dart';
import '../../../constants/string_manager.dart';
import '../../../provider/general_notifier.dart';
import '../../api/auth/login_api.dart';
import '../../service/shared_preferance_service.dart';


class AuthNotifier extends ChangeNotifier {
  final LoginAPI _loginAPI = LoginAPI();

  bool _isLoading = false;
  int? _statusCode;
  String? _token;
  String? _cookie;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  String? get getToken => _token;
  String? get getCookie => _cookie;

  
  CacheService _cashService = CacheService();


  Future<String?> getLogin({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      final generalNotifier = context.read<GeneralNotifier>();


      print("ppppppppppppppppppppp");
      final listData = await _loginAPI.loginUser(email: username, pass: password);

        if(listData["status"] == 200){
          _token= listData["result"]["token"];
          final String email =listData["result"]["user"];
          final String userId =listData["result"]["user_id"].toString();
          final String firstName =listData["result"]["first_name"];
          final String expiryDate =listData["result"]["subscripition_expiry"];
          notifyListeners();
         await _cashService.writeCache(key: AppStrings.token, value: _token ?? "");
         await _cashService.writeCache(key: AppStrings.userName, value:  firstName );
         await _cashService.writeCache(key: AppStrings.userId, value:  userId );
         await _cashService.writeCache(key: AppStrings.email, value:  email );
         await _cashService.writeCache(key: AppStrings.expiryDate, value:  expiryDate );
          _isLoading = false;
          notifyListeners();
          return "OK";
        }else{
          _isLoading = false;
          notifyListeners();
          showDialog(
            context: context,
            builder: (context) {
              return     showAwesomeDialogue(title: "Warning", content: "Please try again later",);
            },
          );

        }

      _isLoading = false;
      notifyListeners();
    } catch(error){
      showDialog(
        context: context,
        builder: (context) {
          return     showAwesomeDialogue(title: "Warning", content: "Please try again later",);
        },
      );
      print("eroor $error");
      _isLoading = false;
      notifyListeners();
}
    return null;
}
}