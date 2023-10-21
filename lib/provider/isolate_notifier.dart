import 'dart:isolate';
import 'dart:math';

import '../models/product_model/product_list_model.dart';


class HeavyTask {
 Future<List> useIsolate({
    required List<ProductListModel> barcodeList,
}) async
  {
    final ReceivePort receivePort = ReceivePort();
    try {
      await Isolate.spawn(
          processingData, [receivePort.sendPort, barcodeList]);
    } on Object {
      receivePort.close();
    }
    final response = await receivePort.first;
    // print('Result: $response');
    return response;
  }

  int processingData(List<dynamic> args) {
    SendPort resultPort = args[0];



  Map<String,ProductListModel>  processedListBarcode={};

  ///barcodeList
  //   for (ProductListModel element in args[1]) {
  //     processedListBarcode[element.BarcodeNo ?? "0"] = element;
  //
  //   }
    List value = [];
    Isolate.exit(resultPort, value);
  }

}
