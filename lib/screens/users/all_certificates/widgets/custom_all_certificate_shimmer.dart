import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_shimmer.dart';

class CustomAllCertificateShimmer extends StatelessWidget {
  const CustomAllCertificateShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 16.w , left: 16.w, top: 20.h),
        itemCount: 7,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) => Container(
          height: 68.h,
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
