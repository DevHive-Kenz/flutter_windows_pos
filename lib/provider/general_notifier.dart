import 'dart:async';
import 'dart:io';

// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kenz/constants/constants.dart';


import '../constants/api_const/api_const.dart';
import '../constants/string_manager.dart';
import '../core/service/shared_preferance_service.dart';
import '../models/product_model/product_content_model.dart';

class GeneralNotifier extends ChangeNotifier {
  int _axisCount = 2;

  String? _userName;
  String? _sysUserID;
  String? _locationCode;
  String? _mobileBatch;
  String? _email;
  String? _displayName;
  String? _ip;
  double _percent =0.00;
  bool _updateDisabled = true;
  bool _netAvailable = false;


  double? get getPercent => _percent;
  bool get getUpdateDisabledBool=> _updateDisabled;
  bool get getNetAvailableBool=> _netAvailable;
  int get getAxisCount => _axisCount;
  String? get getUserName => _userName;
  String? get getIP => _ip;
  String? get getSysUserID => _sysUserID;
  String? get getLocationCode => _locationCode;
  String? get getMobileBatch => _mobileBatch;
  String? get getEmail => _email;
  String? get getDisplay => _displayName;
  CacheService cashService = CacheService();


  void   setPercent(double per){
    _percent = per ;
    notifyListeners();
  }

  Future checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _netAvailable = true;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _netAvailable = false;
      notifyListeners();
    }
  }
  Future<void> checkAxisCount({required BuildContext context}) async {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1200) {
      _axisCount = 5;
    } else if (screenWidth > 1000) {
      _axisCount = 4;
    } else if (screenWidth > 800) {
      _axisCount = 4;
    } else if (screenWidth > 600) {
      _axisCount = 3;
    } else {
      _axisCount = 2;
    }
    notifyListeners();
  }

  Future<void> getUserNameFun() async {
    _userName = await cashService.readCache(key: AppStrings.userName);
    _email = await cashService.readCache(key: AppStrings.email);
    notifyListeners();
  }
}
