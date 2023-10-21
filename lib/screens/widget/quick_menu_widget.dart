import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz/constants/values_manger.dart';

import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/font_manager.dart';
import '../../constants/style_manager.dart';

class QuickMenuWidget extends StatelessWidget {
  const QuickMenuWidget({
    super.key,
    this.name,
    required this.icon,
    this.height =60,
     this.width =70,
    required this.onTap,
     this.isSelected = false,

  });
  final IconData icon;
  final String? name;
  final double height;
  final double width;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),

      child: InkWell(
        onTap:onTap,
        child: Container(
          // height: height.h,
          // width: width.h,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: isSelected ?  ColorManager.white :ColorManager.primaryLight ,

                    size: FontSize.s20,
                  ),
                  name != null ? kSizedBox10 :kSizedBox,
                  name != null ? Text(
                      name ?? "",
                      textAlign: TextAlign.center,
                      style: getRegularStyle(color: isSelected ?  Colors.white : ColorManager.primaryLight,fontSize: FontSize.s16)


                  ):kSizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
