// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/location/location.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomShopDetails extends StatelessWidget {
  const CustomShopDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'اسم السوق او المحل',
            size: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              SvgPicture.asset(
                Assets.svg.location,
                height: 24.w,
                width: 24.w,
                fit: BoxFit.cover,
                color: AppColors.primary,
              ),
              SizedBox(width: 3.w),
              AppText(
                text: '${LocaleKeys.distanceFromYou.tr()} 10كم',
                size: 10.sp,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 15.sp,
                    color: const Color(0xffE5BB45),
                  ),
                  SizedBox(width: 3.w),
                  AppText(
                    text: '+3',
                    size: 14.sp,
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    height: 35.w,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.svg.copy,
                        height: 24.w,
                        width: 24.w,
                        color: Colors.white,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const Location();
                        },
                      );
                    },
                    child: Container(
                      height: 35.h,
                      width: 93.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: AppColors.primary, width: 2.w),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: AppText(
                          text: LocaleKeys.view_on_map.tr(),
                          color: AppColors.primary,
                          size: 10.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
