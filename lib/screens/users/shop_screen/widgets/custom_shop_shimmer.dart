import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/custom_shimmer.dart';
import '../../../../gen/assets.gen.dart';

class CustomShopShimmer extends StatelessWidget {
  const CustomShopShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 26.h,
              width: 158.w,
              margin: EdgeInsetsDirectional.only(top: 24.h, start: 30.w),
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.location,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            height: 15.h,
                            width: 100.w,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 24.sp,
                          ),
                          Container(
                            height: 15.h,
                            width: 50.w,
                            color: Colors.white,
                          ),
                          Container(
                            height: 35.w,
                            width: 35.w,
                            margin: EdgeInsetsDirectional.only(start: 100.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.white),
                          ),
                          Container(
                            height: 35.w,
                            width: 120.w,
                            margin: EdgeInsetsDirectional.only(start: 5.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                itemBuilder: (context, index) => Container(
                  height: 15.h,
                  width: 120.w,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.only(
                top: 10.h,
                start: 10.w,
                end: 10.w,
                bottom: 150.h,
              ),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 205.h,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
              ),
              itemBuilder: (context, index) => Container(
                height: 210.h,
                width: 165.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 140.h,
            )
          ],
        ),
      ),
    );
  }
}
