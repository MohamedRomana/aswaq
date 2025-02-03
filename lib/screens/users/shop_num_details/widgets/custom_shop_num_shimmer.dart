import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_shimmer.dart';

class CustomShopNumShimmer extends StatelessWidget {
  const CustomShopNumShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemBuilder: (context, index) => Container(
                height: 80.h,
                width: 343.w,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            Container(
              height: 90.h,
              width: 343.w,
              padding: EdgeInsets.all(16.r),
              margin: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.white, width: 2.w),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 15.h,
                        width: 150.w,
                        color: Colors.white,
                      ),
                      Container(
                        height: 15.h,
                        width: 50.w,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const Divider(thickness: 2, color: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 15.h,
                        width: 150.w,
                        color: Colors.white,
                      ),
                      Container(
                        height: 15.h,
                        width: 50.w,
                        color: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 140.h)
          ],
        ),
      ),
    );
  }
}
