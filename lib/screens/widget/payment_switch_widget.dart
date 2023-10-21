import 'package:flutter/material.dart';

import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/style_manager.dart';
import '../../constants/values_manger.dart';

class PaymentTypeWidget extends StatelessWidget {
  const PaymentTypeWidget({super.key, required this.icon, required this.title,required this.onTap});
  final String title;
  final IconData icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p24, vertical: AppPadding.p16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorManager.primaryLight,
                ColorManager.onPrimaryLight,
              ],
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: ColorManager.white),
            kSizedBox2,
            Text(
              title,
              style: getSemiBoldStyle(color: ColorManager.white),
            )
          ],
        ),
      ),
    );
  }
}
