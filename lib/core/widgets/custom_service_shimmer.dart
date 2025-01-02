// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aswaq/core/widgets/custom_shimmer.dart';
import '../../gen/fonts.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../constants/colors.dart';
import 'app_text.dart';

class CustomServiceShimmer extends StatelessWidget {
  const CustomServiceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        padding: EdgeInsets.only(
          right: 16.w,
          left: 16.w,
          top: 24.h,
          bottom: 80.h,
        ),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          return Container(
            width: 343.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              border: Border.all(color: AppColors.primaryLight.withOpacity(.2)),
            ),
            child: Row(
              children: [
                Container(
                  height: 48.w,
                  width: 48.w,
                  margin: EdgeInsetsDirectional.only(end: 8.w),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250.w,
                      child: AppText(
                        text: "اسم الخدمة",
                        size: 14.sp,
                        bottom: 8.h,
                        color: AppColors.primaryLight.withOpacity(.2),
                        lines: 2,
                      ),
                    ),
                    SizedBox(
                      width: 250.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                '',
                                width: 12.w,
                                fit: BoxFit.cover,
                                color: AppColors.primaryLight.withOpacity(.2),
                              ),
                              SizedBox(
                                width: 130.w,
                                child: AppText(
                                  start: 3.w,
                                  text: "اسم القسم",
                                  size: 12.sp,
                                  lines: 2,
                                  color: AppColors.primaryLight.withOpacity(.2),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              AppText(
                                text: "${LocaleKeys.price.tr()}: ",
                                size: 12.sp,
                                color: AppColors.primaryLight.withOpacity(.2),
                              ),
                              AppText(
                                text: "147",
                                color: AppColors.primaryLight.withOpacity(.2),
                                family: FontFamily.norsalMedium,
                              ),
                              AppText(
                                text: " ${LocaleKeys.sar.tr()}",
                                size: 14.sp,
                                color: AppColors.primaryLight.withOpacity(.2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
