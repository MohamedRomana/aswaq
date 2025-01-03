// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/screens/users/home_layout/home_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../shop_screen/shop_screen.dart';

class MarketsAndShopsListView extends StatelessWidget {
  const MarketsAndShopsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          top: 22.h,
          start: 21.w,
          text: LocaleKeys.markets_and_shops.tr(),
          size: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        ListView.separated(
          padding: EdgeInsets.all(16.r),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          separatorBuilder: (context, index) => SizedBox(
            height: 16.h,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => AppRouter.navigateTo(context, const ShopScreen()),
              child: Container(
                height: 100.h,
                width: 343.w,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                      offset: Offset(0, 5.r),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        Assets.img.shop.path,
                        height: 100.h,
                        width: 110.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            SizedBox(
                              width: 180.w,
                              child: AppText(
                                text: 'اسم المحل',
                                color: Colors.black,
                                size: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 19.sp,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: const Color(0xffE5BB45),
                              size: 15.sp,
                            ),
                            SizedBox(width: 3.w),
                            AppText(
                              text: '+3',
                              size: 14.sp,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.svg.location,
                              color: AppColors.primary,
                              height: 15.h,
                              width: 15.w,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 3.w),
                            SizedBox(
                              width: 190.w,
                              child: AppText(
                                text:
                                    '${LocaleKeys.distanceFromYou.tr()} 10 كم',
                                color: Colors.grey,
                                size: 10.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Center(
          child: AppButton(
            bottom: 22.h,
            onPressed: () {
              AppCubit.get(context).changebottomNavIndex(0);
              AppRouter.navigateAndFinish(context, const HomeLayout());
            },
            color: Colors.white,
            borderColor: AppColors.primary,
            child: AppText(
              text: LocaleKeys.view_all.tr(),
              color: AppColors.primary,
              size: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
