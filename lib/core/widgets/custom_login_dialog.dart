import 'package:aswaq/core/widgets/custom_lottie_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../../screens/auth/views/login/login.dart';
import '../constants/colors.dart';
import 'app_button.dart';
import 'app_router.dart';
import 'app_text.dart';

class CustomLoginDialog extends StatelessWidget {
  final bool isLogin;
  const CustomLoginDialog({super.key, this.isLogin = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          isLogin ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        CustomLottieWidget(
          height: isLogin ? 350.w : 150.w,
          width: isLogin ? 350.w : 150.w,
          lottieName: Assets.img.login,
        ),
        AppText(
          text: LocaleKeys.loginFirst.tr(),
          size: 20.sp,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 15.h),
        AppButton(
          onPressed: () {
            AppRouter.pop(context);
            AppRouter.navigateTo(context, const LogIn());
          },
          child: AppText(
            text: LocaleKeys.login.tr(),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
