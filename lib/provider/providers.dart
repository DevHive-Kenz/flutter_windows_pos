
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:kenz/provider/pos_sales_notifier.dart';
import 'package:kenz/provider/product_management_notifier.dart';
import 'package:kenz/provider/setup_settings_notifier.dart';

import '../core/notifier/auth/auth_notifier.dart';

import '../core/notifier/category_notifier/category_notifier.dart';
import '../core/notifier/checkinout.dart';
import '../core/notifier/data/pos_post_notifier.dart';
import '../core/notifier/data/product_list_notifier.dart';

import '../core/notifier/profile/profile_notifier.dart';
import '../core/notifier/series_fetch_notifier/series_fetch_notifier.dart';
import 'checken_in_notifier.dart';
import 'customer_notifier.dart';
import 'dataBase_fetch_notifier.dart';
import 'database_functionalities_notifier.dart';
import 'draft_notifier.dart';
import 'general_notifier.dart';
import 'invoice_printing_notifier.dart';
import 'loading_data_notifier.dart';

List<SingleChildWidget> providers = [...providersList];

//independent providers
List<SingleChildWidget> providersList = [

  ChangeNotifierProvider(create: (_) => GeneralNotifier()),
  ChangeNotifierProvider(create: (_) => DataBaseFunctionalities()),
  ChangeNotifierProvider(create: (_) => DataBaseFetchNotifier()),

  ///AUTH
  ChangeNotifierProvider(create: (_) => AuthNotifier()),
  ChangeNotifierProvider(create: (_) => CheckInOutNotifier()),

  ///Products
  ChangeNotifierProvider(create: (_) => ProductListNotifier()),
  ChangeNotifierProvider(create: (_) => ProductManagementNotifier()),
  ChangeNotifierProvider(create: (_) => InvoicePrintingNotifier()),
  ChangeNotifierProvider(create: (_) => CustomerNotifier()),
  ChangeNotifierProvider(create: (_) => SetupSettingsNotifier()),
  ChangeNotifierProvider(create: (_) => PosPostNotifier()),
  ChangeNotifierProvider(create: (_) => SeriesFetchNotifier()),
  ChangeNotifierProvider(create: (_) => ProfileNotifier()),
  ChangeNotifierProvider(create: (_) => CategoryNotifier()),
  ChangeNotifierProvider(create: (_) => CheckOutINIDNotifier()),

  ///Draft
    ChangeNotifierProvider(create: (_) => DraftNotifier()),

  ///recent sale
  ChangeNotifierProvider(create: (_) => PosSaleNotifier()),

];