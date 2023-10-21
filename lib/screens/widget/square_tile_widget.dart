import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz/constants/style_manager.dart';
import 'package:kenz/constants/values_manger.dart';
import '../../constants/app_routes.dart';
import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/font_manager.dart';

class SquareTileWidget extends HookWidget {
  const SquareTileWidget({
    Key? key,

    required this.onTap,
    required this.name,
    required this.nameArabic,
    required this.price,
    this.icon,
    required this.isSelected,
  }) : super(key: key);


  final String name;
  final String nameArabic;
  final String price;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppPadding.p8,vertical: AppPadding.p6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                isSelected ?  ColorManager.primaryLight :Colors.white ,
                isSelected ? ColorManager.onPrimaryLight : Colors.white ,
              ],
            ),

          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                icon != null  ?  Icon(
                    icon,
                    color: isSelected ?  ColorManager.white :ColorManager.primaryLight ,
                    size: FontSize.s36,
                  ): kSizedBox,
                  kSizedBox10,
                  Text(
                    name,
                    textAlign: TextAlign.center,
                      style: getRegularStyle(color: isSelected ?  Colors.white : ColorManager.primaryLight,fontSize: FontSize.s16)

                  ),
                  kDivider,
                  Text(
                    "$nameArabic",
                    textAlign: TextAlign.center,
                      style: getRegularStyle(color: isSelected ?  Colors.white : ColorManager.primaryLight,fontSize: FontSize.s14)

                  ),
                  kSizedBox10,
                  Text(
                    price,
                      textAlign: TextAlign.center,

                      style: getBoldStyle(color: isSelected ?  Colors.white : ColorManager.primaryLight,fontSize: FontSize.s16)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
