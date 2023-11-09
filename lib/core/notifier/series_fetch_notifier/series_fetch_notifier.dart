import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../provider/general_notifier.dart';
import '../../../provider/dataBase_fetch_notifier.dart';
import '../../../provider/database_functionalities_notifier.dart';
import '../../../provider/product_management_notifier.dart';
import '../../api/series_fetch_api/series_fetch_api.dart';
import '../profile/profile_notifier.dart';



class SeriesFetchNotifier extends ChangeNotifier {
  final SeriesFetchApi _seriesFetchAPI = SeriesFetchApi();

  bool _isLoading = false;
  int? _statusCode;
  String? _seriesFetch;


  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  String? get getSeriesFetch => _seriesFetch;




  Future<String?> seriesFetch({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      final generalNotifier = context.read<GeneralNotifier>();
      final productNotifier = context.read<ProductManagementNotifier>();
      final profileNotifier = context.read<ProfileNotifier>();

      await generalNotifier.checkUserConnection();
  if(generalNotifier.getNetAvailableBool ){
    final listData = await _seriesFetchAPI.seriesFetch(type: "INVOICE");

    if(listData["status"] == 200){

      _seriesFetch= listData["result"].toString();
      print("33333333333 ${profileNotifier.getProfile?.result?[0].companySalePrefix}");
      await productNotifier.preSetInvoiceId(context: context, invoiceNumber: int.parse(listData["result"].toString()), prefix: profileNotifier.getProfile?.result?[0].companySalePrefix ?? "INV");
      // currentNotifier.setInvoiceID(invoiceId: listData["result"],displaySeriesId: "${(profileNotifier.getProfile?.result?[0].companySalePrefix)} ${formatString(listData["result"].toString())}");
      _isLoading = false;
      notifyListeners();
      return "OK";
    }else{
      _isLoading = false;
      notifyListeners();
      showAwesomeDialogue(title: "Warning", content: "Please try again", );
    }
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
}