// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_shimmer.dart';

class CustomNotificationShimmer extends StatelessWidget {
  const CustomNotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        physics: const BouncingScrollPhysics(),
        itemCount: 7,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          return Container(
            height: 90.h,
            width: 343.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(.1),
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryLight.withOpacity(.2),
                  blurRadius: 5.r,
                  spreadRadius: 1.r,
                  offset: Offset(0, 5.r),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 36.w,
                  width: 36.w,
                  margin: EdgeInsetsDirectional.only(end: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(.2),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.event_available,
                      color: AppColors.primaryLight.withOpacity(.2),
                      size: 28.sp,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 260.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 170.w,
                            child: AppText(
                              text: "تم الموافقة على طلبك",
                              size: 14.sp,
                              color: AppColors.primaryLight.withOpacity(.2),
                              lines: 2,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: AppColors.primaryLight.withOpacity(.2),
                                size: 18.sp,
                              ),
                              AppText(
                                start: 5.w,
                                text: "منذ 2 ساعة",
                                size: 12.sp,
                                color: AppColors.primaryLight.withOpacity(.2),
                              ),
                            ],
                          )
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
