// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/widgets/custom_shimmer.dart';
import '../../../../../gen/assets.gen.dart';

class CustomHomeShimmer extends StatelessWidget {
  const CustomHomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 36.w,
                  width: 36.w,
                  margin: EdgeInsetsDirectional.only(
                      start: 16.w, top: 60.h, end: 6.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15.h,
                      width: 150.w,
                      margin:
                          EdgeInsetsDirectional.only(top: 60.h, bottom: 6.h),
                      color: Colors.white,
                    ),
                    Container(
                      height: 15.h,
                      width: 120.w,
                      margin: EdgeInsetsDirectional.only(bottom: 5.h),
                      color: Colors.white,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 60.h, start: 120.w),
                  child: SvgPicture.asset(
                    Assets.svg.search,
                    height: 24.w,
                    width: 24.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                height: 150.h,
                width: 343.w,
                margin: EdgeInsets.only(top: 40.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
            ),
            Container(
              height: 15.h,
              width: 150.w,
              margin: EdgeInsetsDirectional.only(
                  top: 30.h, bottom: 10.h, start: 27.w),
              color: Colors.white,
            ),
            ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) => Container(
                height: 100.h,
                width: 343.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 50.h,
                width: 343.w,
                margin: EdgeInsetsDirectional.only(top: 16.h, bottom: 26.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 15.h,
              width: 150.w,
              margin: EdgeInsetsDirectional.only(
                top: 30.h,
                bottom: 10.h,
                start: 27.w,
              ),
              color: Colors.white,
            ),
            SizedBox(
              height: 210.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
                itemBuilder: (context, index) => Container(
                  height: 210.h,
                  width: 165.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 140.h),
          ],
        ),
      ),
    );
  }
}
