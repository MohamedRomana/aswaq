import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_shimmer.dart';

class ShopsListShimmer extends StatelessWidget {
  const ShopsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
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
    );
  }
}
