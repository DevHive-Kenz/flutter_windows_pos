import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';
import '../../constants/asset_manager.dart';
import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/font_manager.dart';
import '../../constants/style_manager.dart';
import '../../constants/values_manger.dart';
import '../../core/notifier/auth/auth_notifier.dart';
import '../../provider/general_notifier.dart';
import '../widget/Circular_progress_indicator_widget.dart';
import '../widget/rounded_button_widget.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final userController = useTextEditingController();
    final passController = useTextEditingController();
    final generalNotifier = context.read<GeneralNotifier>();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Center(
                    child: Image.asset(
                      ImageAssets.houseLogo,
                  height: 120.h,
                )),
              ),
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello 👋",
                          style: getSemiBoldStyle(
                              color: ColorManager.primaryLight,
                              fontSize: FontSize.s30)),
                      Text("Welcome !",
                          style: getSemiBoldStyle(
                              color: ColorManager.primaryLight,
                              fontSize: FontSize.s28)),
                      kSizedBox50,
                      SizedBox(
                        width: 100.w,
                        child: AuthTextField(
                            userController: userController,
                            title: "Enter User Name",
                            isPassword: false),
                      ),
                      kSizedBox20,
                      SizedBox(
                        width: 100.w,
                        child: AuthTextField(
                          userController: passController,
                          title: "Enter Password",
                          isPassword: true,
                        ),
                      ),
                      // kSizedBox10,
                      // Align(
                      //     alignment: Alignment.centerRight,
                      //     child: TextButton(
                      //         onPressed: () {},
                      //         child: Text("Set IP Address",
                      //             style: getSemiBoldStyle(
                      //                 color: ColorManager.primaryLight,
                      //                 fontSize: FontSize.s16)))),
                      kSizedBox35,
                      SizedBox(
                        width: 100.w,
                        child: Consumer<AuthNotifier>(
                            builder: (context, snapshot, _) {
                          return snapshot.getIsLoading
                              ? const CircularProgressIndicatorWidget()
                              : CustomButton(
                            width: 150.w,
                                  title: "Login",
                                  onTap: () async {
                                    if (formKey.currentState?.validate() ??false ) {
                                      await snapshot.getLogin(
                                          context: context,
                                          username: userController.text,
                                          password: passController.text).then((value) {
                                        if(value == "OK"){
                                          Navigator.pushReplacementNamed(context, mainRoute);
                                        }
                                      });
                                    }
                                  },
                                );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AuthTextField extends HookWidget {
  const AuthTextField({
    Key? key,
    required this.userController,
    required this.title,
    required this.isPassword,
  }) : super(key: key);

  final TextEditingController userController;
  final String title;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    ValueNotifier obsecure = useState<bool>(isPassword);
    return TextFormField(
      controller: userController,
      obscureText: obsecure.value,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      style:
          getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s14),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: title,

          hintStyle: TextStyle(color: Colors.grey),
          prefixIconColor: Colors.red,
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.grey5, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primaryLight, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD32F2F), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD32F2F), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                      obsecure.value ? Icons.visibility_off : Icons.visibility,
                      color: ColorManager.primaryLight),
                  onPressed: () => obsecure.value = !obsecure.value,
                )
              : kSizedBox),
    );
  }
}
