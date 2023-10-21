import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';
import '../../constants/asset_manager.dart';
import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/font_manager.dart';
import '../../constants/style_manager.dart';
import '../../constants/values_manger.dart';
import '../../core/service/shared_preferance_service.dart';
import '../../provider/general_notifier.dart';
import '../widget/appbar_main_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final generalNotifier = context.read<GeneralNotifier>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        leading: IconButton(onPressed: ()=> Navigator.pop(context),icon: Icon(Icons.arrow_back,color: ColorManager.black,),),
        title: Text("Settings",style: getBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            kSizedBox20,
            Center(
              child: CircleAvatar(

                radius: 80.r,
                backgroundImage: AssetImage(
                    ImageAssets.houseLogo),
              ),
            ),
            kSizedBox10,
            Text("Name: ${generalNotifier.getDisplay}",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s14),),
            Text("Email: ${generalNotifier.getEmail}",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s14),),
            Text("Location Code: ${generalNotifier.getLocationCode}",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s14),),
            Text("Mobile Batch: ${generalNotifier.getMobileBatch}",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s14),),
            Text("User ID: ${generalNotifier.getSysUserID}",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s14),),
            kSizedBox30,
            InkWell(
              onTap: (){
                // AwesomeDialog(
                //     dismissOnTouchOutside: true,
                //     context: context,
                //     dialogType: DialogType.question,
                //     animType: AnimType.bottomSlide,
                //
                //     title: "Confirmation",
                //     desc: "Are you sure you want to logout",
                //     descTextStyle: getSemiBoldStyle(color: ColorManager.primaryLight),
                //     // desc:'Please login again',
                //     btnCancelOnPress: () {},
                //     btnOkText: "yes",
                //     btnOkOnPress: () async {
                //       CacheService cacheService = CacheService();
                //       await cacheService.deleteSignUpCache();
                //       Navigator.pushNamedAndRemoveUntil(context,loginRoute,(Route<dynamic> route) => false);
                //     },
                //     btnOkColor: ColorManager.primaryLight)
                //     .show();
              },
              child: Container(
                height: 60.h,
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                decoration: BoxDecoration(
                  color: ColorManager.filledColor2,
                ),
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded,size: FontSize.s28,),
                    kSizedW30,
                    Text("Logout",style: getBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),)
                  ],
                ),

              ),
            )
            


          ],
        ),
      ),
    );
  }
}
