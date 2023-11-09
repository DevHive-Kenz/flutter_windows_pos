

// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../constants/constants.dart';
import '../constants/string_manager.dart';
class DataBaseFunctionalities extends ChangeNotifier {
  LazyBox? _box;
  dynamic _fetchedData;

  get getFetchedData => _fetchedData;

  Future<void> saveDataBase({required String dbName, required dbData}) async {
    try {
      if (!Hive.isBoxOpen(AppStrings.dbName)) {
        _box = await Hive.openLazyBox(AppStrings.dbName,);
      }
      await _box?.put(dbName, dbData);
      print("lopp${dbName}");
    } catch (e) {
      // showAwesomeDialogue(title: "Error", content: "Database Error\nPlease try again later", type: DialogType.ERROR);
      print("db error $e");
    }
  }

  Future<void> fetchDatabase({required String dbName}) async {
    try{
      if (!(Hive.isBoxOpen(AppStrings.dbName))) {
        _box = await Hive.openLazyBox(AppStrings.dbName);
        _fetchedData = await _box?.get(dbName);
        notifyListeners();
      }else{
        _fetchedData = await _box?.get(dbName);
        notifyListeners();
      }
    }catch(e){
      // showAwesomeDialogue(title: "Error", content: "Database Fetch Error\nPlease try again later", type: DialogType.ERROR);
    }
  }

  Future<void> deleteDB({required String dbTable}) async {
    try{
      if (!(Hive.isBoxOpen(AppStrings.dbName))) {
        _box = await Hive.openLazyBox(AppStrings.dbName);
        await _box?.delete(dbTable);
        notifyListeners();
      }else{
        await _box?.delete(dbTable);
        print("pppppppppppp");
        notifyListeners();
      }
    }catch(e){
      // showAwesomeDialogue(title: "Error", content: "Database Delete Error\nPlease try again later", type: DialogType.ERROR);
    }

  }

}