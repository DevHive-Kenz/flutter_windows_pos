import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:kenz/provider/providers.dart';

import 'constants/app_routes.dart';
import 'constants/theme_manager.dart';
import 'models/category_model/category_model.dart';
import 'models/category_model/category_result_model.dart';
import 'models/pos_sales_model/payment_type_model.dart';
import 'models/pos_sales_model/sales_model.dart';
import 'models/pos_sales_model/sales_product_model.dart';
import 'models/pos_sales_model/sales_shift_model.dart';
import 'models/product_model/product_content_model.dart';
import 'models/product_model/product_list_model.dart';
import 'models/product_model/product_model.dart';

import 'package:path_provider/path_provider.dart' as pathProvider;

import 'models/check_in_model/check_in_model.dart';
import 'models/profile_model/profile_model.dart';
import 'models/profile_model/profile_result_model.dart';

//delete this whenever you got context idea
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  var path = directory.absolute.path;
  print("444$path");
  Hive
    ..init(path)
    ..registerAdapter(ProductModelAdapter())
    ..registerAdapter(ProductListModelAdapter())
    ..registerAdapter(ProductContentModelAdapter())
    ..registerAdapter(CheckInModelAdapter())
    ..registerAdapter(PaymentTypeModelAdapter())
    ..registerAdapter(PosSalesModelAdapter())
    ..registerAdapter(SalesProductModelAdapter())
    ..registerAdapter(CategoryModelAdapter())
    ..registerAdapter(CategoryResultModelAdapter())
    ..registerAdapter(ProfileModelAdapter())
    ..registerAdapter(ProfileResultModelAdapter())
    ..registerAdapter(SalesShiftModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Builder(builder: (context) {
        return ScreenUtilInit(
          designSize: const Size(360, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_,k) => OverlaySupport(
            child: MaterialApp(

              navigatorKey: navigatorKey,
              scaffoldMessengerKey: snackbarKey,
              theme: getApplicationTheme(),
              debugShowCheckedModeBanner: false,
              routes: routes,
              initialRoute: introRoute,
              // initialRoute: loginRoute,
            ),
          ),
        );
      }),
    );
  }
}


