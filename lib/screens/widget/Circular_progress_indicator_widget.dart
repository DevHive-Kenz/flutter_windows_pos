import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/font_manager.dart';
import '../../constants/style_manager.dart';
import '../../provider/general_notifier.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({Key? key,this.show = false}) : super(key: key);
  final bool show;
  @override
  Widget build(BuildContext context) {
    final generalNotifier = context.watch<GeneralNotifier>();

    return      Stack(
      children: <Widget>[
        Center(
          child: Container(
            width:show ? 80.h : 40.h,
            height: show ? 80.h : 40.h,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: ColorManager.primaryLight,
              strokeWidth: show ? 8.0 : 4.0,
              valueColor: AlwaysStoppedAnimation<Color>(ColorManager.white  ),
            ),
          ),
        ),
       show ? Center(child: Text("${generalNotifier.getPercent?.toStringAsFixed(2) ?? 0.00.toStringAsFixed(2)}%",style: getBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s14),)):kSizedBox,
      ],
    );



    //   Center(
    //   child: CircularProgressIndicator.adaptive(
    //     backgroundColor: ColorManager.primaryLight,
    //     valueColor: AlwaysStoppedAnimation<Color>(ColorManager.white),
    //   ),
    // );
  }
}
