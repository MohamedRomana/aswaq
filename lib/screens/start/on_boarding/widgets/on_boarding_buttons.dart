// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/constants/colors.dart';
import 'package:aswaq/screens/auth/views/login/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';

class CustomOnBoardingButtons extends StatelessWidget {
  const CustomOnBoardingButtons({
    super.key,
    required this.pagesList,
    required this.currPage,
    required this.pageController,
  });

  final List pagesList;
  final double currPage;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      end: 0,
      bottom: 48.h,
      child: Row(
        children: [
          Visibility(
            visible: currPage <= pagesList.length - 1.5,
            child: Column(
              children: [
                SizedBox(height: 12.h),
                TextButton(
                  onPressed: () {
                    pageController.animateToPage(
                      pagesList.length - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: AppText(
                    text: "تخطي",
                    color: Colors.black,
                    size: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 170.w),
          InkWell(
            onTap: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              width: 125.w,
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.r),
                  bottomRight: Radius.circular(25.r),
                ),
              ),
              child: currPage <= pagesList.length - 1.5
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        AppText(
                          text: 'التالي',
                          color: Colors.white,
                          size: 18.sp,
                          family: Assets.fonts.norsalBold,
                        ),
                      ],
                    )
                  : InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if (currPage == pagesList.length - 1) {
                          CacheHelper.setLang('ar');
                          context.setLocale(const Locale('ar'));
                          AppRouter.navigateAndPop(context, const LogIn());
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                          AppText(
                            text: 'ابدأ الأن',
                            color: Colors.white,
                            size: 18.sp,
                            family: Assets.fonts.norsalBold,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
