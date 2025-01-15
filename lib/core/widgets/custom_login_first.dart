import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../generated/locale_keys.g.dart';
import '../../screens/auth/views/login/login.dart';
import '../constants/colors.dart';
import 'app_button.dart';
import 'app_router.dart';
import 'app_text.dart';

class CustomLoginFirst extends StatelessWidget {
  const CustomLoginFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: LocaleKeys.loginFirst.tr(),
          size: 24.sp,
          color: AppColors.primary,
        ),
        SizedBox(height: 30.h),
        AppButton(
          onPressed: () {
            AppRouter.navigateAndPop(context, const LogIn());
          },
          child: AppText(
            text: LocaleKeys.login.tr(),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ));
  }
}
