import 'package:aswaq/core/cache/cache_helper.dart';
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/gen/assets.gen.dart';
import 'package:aswaq/screens/auth/views/login/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/custom_lang_choice.dart';
import 'widgets/custom_type_choice.dart';

class Types extends StatelessWidget {
  const Types({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.img.logo.path,
                  height: 85.h,
                  width: 188.w,
                  fit: BoxFit.cover,
                ),
                const CustomLangChoice(),
                const CustomTypeChoice(),
                AppButton(
                  top: 16.h,
                  onPressed: () {
                    if (AppCubit.get(context).changeLangIndex == 0) {
                      CacheHelper.setLang('ar');
                      context.setLocale(const Locale('ar'));
                    } else {
                      CacheHelper.setLang('en');
                      context.setLocale(const Locale('en'));
                    }
                    AppRouter.navigateAndPop(context, const LogIn());
                  },
                  child: AppText(
                    text: 'تأكيد',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    size: 18.sp,
                  ),
                ),
                AppText(
                  top: 33.h,
                  text: 'الرئيسية',
                  size: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
