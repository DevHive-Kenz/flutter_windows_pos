import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz/constants/asset_manager.dart';
import 'package:kenz/constants/color_manger.dart';
import 'package:kenz/constants/constants.dart';
import 'package:kenz/constants/style_manager.dart';
import 'package:kenz/constants/values_manger.dart';
import 'package:kenz/core/notifier/data/product_list_notifier.dart';
import 'package:kenz/core/notifier/series_fetch_notifier/series_fetch_notifier.dart';
import 'package:kenz/core/notifier/category_notifier/category_notifier.dart';
import 'package:kenz/core/notifier/profile/profile_notifier.dart';
import 'package:kenz/core/notifier/checkinout.dart';
import 'package:provider/provider.dart';
import 'package:kenz/screens/login_screen/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/service/shared_preferance_service.dart';
import 'home_screen/home_screen.dart';
import 'package:kenz/provider/product_management_notifier.dart';
import 'package:kenz/provider/checken_in_notifier.dart';
import 'package:kenz/provider/draft_notifier.dart';
import 'package:kenz/provider/pos_sales_notifier.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    super.initState();
  }

  _asyncMethod() async {
    await Future.wait([
      context.read<ProductListNotifier>().getProductList(context: context),
      context.read<CategoryNotifier>().category(context: context),
      context.read<ProfileNotifier>().profile(context: context),
      context.read<SeriesFetchNotifier>().seriesFetch(context: context),

      context.read<ProductManagementNotifier>().retrieveOrderAndInvoiceID(context: context),
      context.read<CheckInOutNotifier>().retrieveCheckIn(context: context),
      context.read<DraftNotifier>().retrieveDraftID(context: context),
      context.read<DraftNotifier>().retrieveDraftInvoice(context: context),
      context.read<PosSaleNotifier>().retrieveResentInvoice(context: context),
      context.read<CheckOutINIDNotifier>().retrieveCheckInID(context: context),
    ]);
  }


  @override
  Widget build(BuildContext context) {

    Future<void> _launchUrl() async {
      if (!await launchUrl(Uri.parse("https://einvoice.kenztechnology.shop/sales/sale_return"))) {
        throw Exception('Could not launch https://einvoice.kenztechnology.shop/sales/sale_return');
      }
    }

    return Scaffold(

      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            showToggle: true,
            style: SideMenuStyle(
              showTooltip: false,
              displayMode: SideMenuDisplayMode.compact,
              openSideMenuWidth: 50.w,
              compactSideMenuWidth: 60,

              hoverColor: ColorManager.filledColor,
              selectedHoverColor:ColorManager.filledColor ,
              selectedColor: ColorManager.primaryLight,
              selectedTitleTextStyle: getBoldStyle(color: ColorManager.white),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
            ),
            title: Column(
              children: [
                kSizedBox20,
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p20),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 150,
                        maxWidth: 150,
                      ),
                      child: Image.asset(ImageAssets.houseLogo)
                  ),
                ),
                kSizedBox20,

              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text(
                    'Developed With ❤️ Ashif',
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                ),
              ),
            ),
            items: [
              SideMenuItem(

                title: 'POS Sale',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              SideMenuItem(
                title: 'Sales Return',
                onTap: (index, _) {
                  _launchUrl();
                },
                icon: const Icon(Icons.shopping_cart_checkout_rounded),
              ),
              // SideMenuItem(
              //   title: 'Files',
              //   onTap: (index, _) {
              //     sideMenu.changePage(index);
              //   },
              //   icon: const Icon(Icons.file_copy_rounded),
              //   // trailing: Container(
              //   //     decoration: const BoxDecoration(
              //   //         color: Colors.amber,
              //   //         borderRadius: BorderRadius.all(Radius.circular(6))),
              //   //     child: Padding(
              //   //       padding: const EdgeInsets.symmetric(
              //   //           horizontal: 6.0, vertical: 3),
              //   //       child: Text(
              //   //         'New',
              //   //         style: TextStyle(fontSize: 11, color: Colors.grey[800]),
              //   //       ),
              //   //     )),
              // ),

              SideMenuItem(
                title: 'Log Out',
                onTap: (index, _) async {
                  CacheService cacheService = CacheService();
                  await cacheService.deleteSignUpCache();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.logout),
              ),
              // SideMenuItem(
              //   onTap:(index, _){
              //     sideMenu.changePage(index);
              //   },
              //   icon: const Icon(Icons.image_rounded),
              // ),
              // SideMenuItem(
              //   title: 'Only Title',
              //   onTap:(index, _){
              //     sideMenu.changePage(index);
              //   },
              // ),
              // const SideMenuItem(
              //   title: 'Exit',
              //   icon: Icon(Icons.exit_to_app),
              // ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                HomeScreen(),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Users',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Files',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Only Title',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Only Icon',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
