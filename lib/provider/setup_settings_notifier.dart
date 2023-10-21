import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:kenz/constants/constants.dart';
import 'package:kenz/constants/string_manager.dart';
import 'package:kenz/core/service/shared_preferance_service.dart';

import '../constants/color_manger.dart';
import '../constants/style_manager.dart';
import '../constants/values_manger.dart';
import '../models/check_in_model/check_in_model.dart';
import '../screens/widget/rounded_button_widget.dart';
import 'dataBase_fetch_notifier.dart';
import 'database_functionalities_notifier.dart';

class SetupSettingsNotifier extends ChangeNotifier{


  CacheService _cacheService = CacheService();
  String? _currency = "SAR";
  double _vatPercentage = 15;

  String? get getCurrency=> _currency;
  double get getVatPercentage=> _vatPercentage;





}