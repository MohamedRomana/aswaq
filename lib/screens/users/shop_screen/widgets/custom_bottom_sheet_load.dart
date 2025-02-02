import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_shimmer.dart';

class CustomBottomSheetLoading extends StatelessWidget {
  const CustomBottomSheetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 210.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: 20.h,
                      width: 150.w,
                      margin:
                          EdgeInsetsDirectional.only(top: 16.h, bottom: 16.h),
                      color: Colors.white,
                    ),
                    Container(
                      height: 20.h,
                      width: 150.w,
                      margin:
                          EdgeInsetsDirectional.only(top: 16.h, bottom: 16.h),
                      color: Colors.white,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  height: 20.h,
                  width: 100.w,
                  margin: EdgeInsetsDirectional.only(top: 16.h, bottom: 16.h),
                  color: Colors.white,
                ),
              ],
            ),
            const Divider(
              thickness: 2,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 16.h),
              height: 20.h,
              width: 150.w,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 16.h, bottom: 6.h),
              height: 20.h,
              width: 343.w,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsetsDirectional.only(bottom: 6.h),
              height: 20.h,
              width: 343.w,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsetsDirectional.only(bottom: 6.h),
              height: 20.h,
              width: 343.w,
              color: Colors.white,
            ),
            Row(
              children: [
                Container(
                  height: 24.w,
                  width: 24.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.w),
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 8.h, bottom: 10.h),
                  height: 20.h,
                  width: 150.w,
                  color: Colors.white,
                ),
              ],
            ),
            const Divider(
              thickness: 2,
              color: Colors.white,
            ),
            Row(
              children: [
                Container(
                  height: 24.w,
                  width: 24.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  height: 20.h,
                  width: 30.w,
                  color: Colors.white,
                ),
                Container(
                  height: 24.w,
                  width: 24.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 60.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
