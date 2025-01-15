// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_shimmer.dart';

class CustomProfileShimmer extends StatelessWidget {
  const CustomProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 101.h,
            width: 343.w,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            height: 50.h,
            width: 343.w,
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            clipBehavior: Clip.antiAlias,
            height: 50.h,
            width: 343.w,
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            clipBehavior: Clip.antiAlias,
            height: 50.h,
            width: 343.w,
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            clipBehavior: Clip.antiAlias,
            height: 50.h,
            width: 343.w,
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ],
      ),
    );
  }
}
